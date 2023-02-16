class convert{
  Map<String,int> listToMap(List<String> items){
    Map<String,int> res={};
    for(var it in items){
      if(res.containsKey(it)){
        res[it]=res[it]!+1;
      }else{
        res[it]=1;
      }
    }
    return res;
  }
  // void add
}