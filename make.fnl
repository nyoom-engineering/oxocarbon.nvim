(let [{: build} (require :hotpot.api.make)
      (oks errs) (build :./fnl {:force? true :atomic? true} "./fnl/(.+)"
                        (fn [p {: join-path}]
                          (join-path :./lua p)))]
  (values nil))
