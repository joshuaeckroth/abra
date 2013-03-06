Requirements: 
  Common Lisp interpreter (tested and developed on SBCL)
  ASDF
  

Set up:
  edit ~/.config/common-lisp/source-registry.conf.d/abra-asd.conf
  to include the following line with the directory replaced.
  (:tree "/path/to/your/abra/directory/")
  edit the path in interface/path.lisp to point to your abra installation

Running:
  start SBCL and type (require "abra")
  switch to the abra package with (in-package "abra")
  run an test case by typing
     (load-problem "flu/1")
     (test-flu 200)
