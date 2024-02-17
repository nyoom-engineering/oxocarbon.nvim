(let [{: build} (require :hotpot.api.make)
      (oks errs) (build :./fnl {:force? true :atomic? true}
                        [[:**/*.fnl (fn [path] (string.gsub path :fnl :lua))]])]
  (values nil))
