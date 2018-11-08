#ifndef HCM_H
#define HCM_H

#include <map>
#include <string>
#include <vector>
#include <iostream>
#include <typeinfo>
#include <assert.h>
#include "hcm_common.h"

#define stringify( name ) # name
// return codes:
typedef enum hcmResultTypes { 
  OK, 
  BAD_PARAM, 
  NO_MEM, 
  NOT_FOUND,
  PROPERTY_EXISTS_WITH_DIFFERENT_TYPE 
} hcmRes;

enum NetType_ { 
  NullNet,
  WireNet,
  TriNet,
  WandNet,
  WorNet,
  RegNet,
  Supply1Net,
  Supply0Net
};
typedef enum NetType_ NetType;

typedef enum hcmPortTypes { 
  NOT_PORT, 
  IN, 
  OUT, 
  IN_OUT
} hcmPortDir;

struct Range {
  hcmPortDir dir;
  NetType type;
  int upper,lower;
};

// possible exceptions thrown:

// prototypes:
class hcmProperty;
class hcmObject;
class hcmDesign;
class hcmCell;
class hcmInstance;
class hcmNode;
class hcmInstPort;
class hcmPort;

// Nore properties are type'd and can;'t change
class hcmProperty {
 public:
  virtual ~hcmProperty(){};
};

template <typename T>
class hcmTypedProperty: public hcmProperty {
 private:
  hcmTypedProperty(){
    //  values = new std::map<std::string,T>();
  }

 public:

  std::map<std::string, T > values;

  T* get(std::string key){
    if(values.count(key)){
      return &values[key];
    }
    return NULL;
  }
  void add(std::string name, T value){
    values[name] = value;
  }
  void remove(std::string key){
    values.erase(key);
  }

  friend class hcmObject;
};

class hcmObject {
  std::map< std::string, hcmProperty* > props;
  std::map< std::string, std::string > propNameToType;
 protected:
  std::string name;
  bool destructorCalled;
  hcmObject();
 public:
  const std::string getName() const;
  template <typename T>
    hcmRes getProp(std::string name, T& value){
    if(props.count(typeid(T).name())){
      hcmTypedProperty<T>* typedProp = 
	dynamic_cast<hcmTypedProperty<T>*>(props[typeid(T).name()]);
      if(typedProp == NULL){
        std::cout << "ERROR: NULL TYPED PROP" << std::endl;
        return NOT_FOUND;
      }
      T* r = typedProp->get(name);
      if(r!= NULL){
        value = *r;
        return OK;
      }
    }
    return NOT_FOUND;
  }

  template <typename T>
    hcmRes setProp(std::string name, T value){
    std::string typeName = typeid(T).name();
    if(propNameToType.count(name) && propNameToType[name]!=typeName ){
      return PROPERTY_EXISTS_WITH_DIFFERENT_TYPE;
    }
    if(props.count(typeName)==0){
      props[typeName] = new hcmTypedProperty<T>();
    }
    hcmProperty* prop = props[typeName];
    hcmTypedProperty<T>* typedProp = dynamic_cast<hcmTypedProperty<T>*>(prop);
    typedProp->add(name,value);
    propNameToType[name] = typeName;
    return OK;
  }

  template <typename T>
    hcmRes delProp(std::string name){
    if(propNameToType.count(name) == 0) {
      return NOT_FOUND;
    }
    if(propNameToType[name] != typeid(T).name()){
      return PROPERTY_EXISTS_WITH_DIFFERENT_TYPE;
    }
    hcmTypedProperty<T>* typedProp = 
      dynamic_cast<hcmTypedProperty<T>*>(props[propNameToType[name]]);
    typedProp->remove(name);
    return OK;
  }

  /*hcmRes getProp(std::string name, std::string &s);
    hcmRes getProp(std::string name, long int &i);
    hcmRes getProp(std::string name, double &d);
    // implicitly create new prop or update it
    hcmRes setProp(std::string name, std::string s);
    hcmRes setProp(std::string name, long int i);
    hcmRes setProp(std::string name, double d);
    hcmRes delProp(std::string name);*/
};

class hcmInstPort : public hcmObject {
  hcmInstance* inst;
  hcmNode* connectedNode;
  hcmPort* connectedPort;
  hcmInstPort(hcmInstance* instance, hcmNode* node, hcmPort* port);

 public:
  void printInfo();
  ~hcmInstPort();
  hcmNode *getNode() const
  {
    return connectedNode;
  }

  hcmPort *getPort() const
  {
    return connectedPort;
  }

  hcmInstance *getInst() const
  {
    return inst;
  }

  void setConnectedNode(hcmNode *connectedNode)
  {
    this->connectedNode = connectedNode;
  }

  friend class hcmCell;
};

class hcmPort : public hcmObject {
  std::map< std::string , hcmInstPort *> instPorts;
  hcmNode* node;
  hcmPortDir dir;
  hcmPort(std::string portName, hcmNode* ownerNode, hcmPortDir direction);
  void printInfo();
 public:
  hcmPortDir getDirection() const{
    return dir;
  }
  hcmNode* owner();
  ~hcmPort();

  friend class hcmNode;
};

class   hcmNode : public hcmObject {
  std::map< std::string , hcmInstPort *> instPorts;
  hcmPort *port;
  hcmCell *cell;
  bool connectPort(hcmInstPort* instPort);
  bool disconnectPort(hcmInstPort* instPort);
  hcmNode(std::string name, hcmCell *cell);
  void printInfo();
 public:
  ~hcmNode();
  hcmCell* owner();
  hcmPort *createPort(hcmPortDir dir);
  hcmRes deletePort();
  hcmPort *getPort();
  const hcmPort *getPort() const;
        
  std::map<std::string, hcmInstPort* > &getInstPorts();
  const std::map<std::string, hcmInstPort* > &getInstPorts() const;
        
  friend class hcmCell;
};

class hcmInstance : public hcmObject {
  std::map< std::string , hcmInstPort *> instPorts;
  hcmCell* master;
  hcmCell* cell;
  hcmInstance(std::string instanceName, hcmCell* masterCell);
  bool connectInstance(hcmCell* cell);
  void printInfo();
 public:
  hcmCell* owner();  //Containing cell
  hcmCell* masterCell();
  const hcmCell* masterCell() const { return master; };
  ~hcmInstance();
  vector<hcmPort*> getAvailablePorts();
  vector<hcmPort*> getAvailablePorts(std::string nodeName); //For returning bus ports.

  std::map<std::string, hcmInstPort* > &getInstPorts();
  const std::map<std::string, hcmInstPort* > &getInstPorts() const;
  hcmInstPort* getInstPort(string name);
  const hcmInstPort* getInstPort(string name) const;

  friend class hcmCell;
};

class hcmCell : public hcmObject {
  hcmDesign *design;
  std::map< std::string, hcmInstance* > cells;
  std::map< std::string, hcmInstance* > myInstances;
  std::map< std::string, hcmNode* > nodes;
  std::map< std::string, pair<int,int> > buses;

  bool instPortParametersValid(hcmInstance *inst, hcmNode *node, hcmPort* port);
  hcmCell(std::string name, hcmDesign* d); // throw if not unique

  void printInfo();
 public:
  ~hcmCell();
  hcmDesign* owner();
  hcmInstance *createInst(std::string name, hcmCell* masterCell);
  hcmInstance *createInst(std::string name, std::string masterCellName);
  hcmRes deleteInst(std::string name);
  hcmNode *createNode(std::string name);
  hcmRes deleteNode(std::string name);
  void createBus(std::string name, int high , int low, hcmPortDir dir = NOT_PORT);
  void deleteBus(std::string name);
  //Connect:
  // Returns NULL if it failed to connect
  // If the PortName is a bus, the function returns a RANDOM 
  // hcmInstPort with one of the bus' nodes.
  // Otherwise it returns the hcmInstPort that was created. 
  hcmInstPort *connect(hcmInstance *inst, hcmNode *node, hcmPort* port);
  hcmInstPort *connect(hcmInstance *inst, hcmNode *node, std::string portName);
  
  static hcmRes disConnect(hcmInstPort *instPort); // equals to: delete instPort;

  hcmInstance *getInst(std::string name);
  hcmNode *getNode(std::string name);
  hcmPort *getPort(std::string name);
  const hcmInstance *getInst(std::string name) const;
  const hcmNode *getNode(std::string name) const;
  const hcmPort *getPort(std::string name) const;

  vector<hcmPort*> getPorts();
  std::map< std::string, hcmInstance* > & getInstances();
  const std::map< std::string, hcmInstance* > & getInstances() const;
  std::map< std::string, hcmInstance* > & getInstantiations();
  std::map< std::string, hcmNode* >     & getNodes();
  const std::map< std::string, hcmNode* > & getNodes() const;
  
  friend class hcmInstance;
  friend class hcmDesign;
};

class hcmDesign : public hcmObject {
  std::map< std::string, class hcmCell* > cells;
 public:
  hcmDesign(std::string name);
  ~hcmDesign();
  hcmCell *createCell(std::string name);
  bool deleteCell(std::string name);
  hcmCell *getCell(std::string name);
  void printInfo();
  hcmRes parseStructuralVerilog(const char *fileName);
};

#endif
