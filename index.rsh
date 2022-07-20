'reach 0.1';


export const main = Reach.App(() => {
  setOptions({ untrustworthyMaps: true });
  const D = Participant('Admin', {
    ready: Fun([], Null),
    log: Fun(true, Null)
  });
  const W = API('Whitelist', {
    addAddress: Fun([], Null) // Recieves an address from the frontend, Should it
  });

  init();

  D.publish();
  D.interact.ready();
  // commit()

  const whitelistMap = new Set()


  const [keepGoing] = 
  parallelReduce([true])
    .invariant(balance()==0)
    .while(keepGoing)
    .api_(W.addAddress, () => {
      check( ! whitelistMap.member(this), "Address added");
      return [(k) => {
        k(null);
        whitelistMap.insert(this);
        D.interact.log(this, " was added")
        return [keepGoing]
      }]
    })
    .timeout(false)
  commit()
  exit();
});