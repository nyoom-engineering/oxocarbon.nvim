;;; Utilities
(fn make-directory! [name]
  (os.execute (.. "mkdir " name)))

(fn remove-directory! [name]
  (os.execute (.. "rm -r " name)))

(fn file-exists? [path]
  (let [f (io.open path :r)]
   (not= f nil)))

(fn create-file! [path content]
  (let [file (io.open path :w)]
    (file:write content)
    (file:close)))

(fn pretty-print [element]
  (if (= (type element) "table")
      (each [key value (pairs element)]
        (print (.. key ": " value)))
      (print (tostring element))))


;;; Build options
;; Contributors may wanna change this depending on where they have `fennel` installed on their system.
(local fennel-install "fennel")
(when (not (file-exists? fennel-install))
  (print "[ERROR] Cannot find fennel installation! Check path of fennel-install variable!")
  (os.exit 1))

(local source-directory "fnl")
(local target-directory "lua")


;;; Build script
(fn get-directories-in [dir]
  (: (io.popen (.. "find " dir " -type d")) :lines))

(fn get-fnl-files-in [dir]
  (: (io.popen (.. "find " dir " -name '*.fnl'")) :lines))

(fn get-directory-content [dir]
  (icollect [file (get-fnl-files-in dir)]
    file))

(fn remake-directories [folder target]
  (each [dir (get-directories-in folder)]
    (make-directory! (string.gsub dir folder target))))

(fn compile [path]
  (local result {:content "" :filename ""})
  (local output (io.popen (.. fennel-install " -c " path)))
  (tset result :content (output:read "*a"))
  (tset result :filename (string.gsub path source-directory target-directory))
  result)

(fn create-files []
  (each [_ file (pairs (get-directory-content source-directory))]
    (let [f (compile file)
          filename (. f :filename)
          content (. f :content)]
      (create-file! filename content))))

(fn build []
  (when (file-exists? (.. target-directory "/oxocarbon/init.lua"))
      (remove-directory! target-directory))
  (remake-directories source-directory target-directory)
  (create-files))

(build)
