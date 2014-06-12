(create-rules

 ;; # find a file named arg1

 (:antecedent

  ;; find(Prename,Name,Size,Prepath,Path)|

  ((find ?prename ?name ?size ?prepath ?path))

  :consequent
  (
   ;; find-file-by-attr-name-exact(Name),file-prepath(Prename),

   (find-file-by-attr-name-exact ?name)

   (file-prepath ?prename)

   ;; file-size(Size),source-dir-prepath(Prepath),source-dir-name(Path).

   (file-size ?size)

   (source-dir-prepath ?prepath)

   (source-dir-name ?path)

  ))

 (:antecedent

  ;; cd(Prepath,Path)|

  ((cd ?prepath ?path))

  :consequent
  (
   ;; find-file-by-attr-name-exact(Name),source-dir-prepath(Prepath),

   (find-file-by-attr-name-exact ?name)

   (source-dir-prepath ?prepath)

   ;; source-dir-name(Path).

   (source-dir-name ?path)

  ))

 (:antecedent

  ;; ls(Path,Name)|

  ((ls ?path ?name))

  :consequent
  (
   ;; find-file-by-attr-name-exact(Name),source-dir-prepath(Path),

   (find-file-by-attr-name-exact ?name)

   (source-dir-prepath ?path)

   ;; file-name(Name).

   (file-name ?name)

  ))

 ;; #find a file that ends in arg1

 (:antecedent

  ;; find(Prename,Ext,Size,Prepath,Path)|

  ((find ?prename ?ext ?size ?prepath ?path))

  :consequent
  (
   ;; find-file-by-attr-name-ext(Ext),file-prepath(Prename),file-size(Size),

   (find-file-by-attr-name-ext ?ext)

   (file-prepath ?prename)

   (file-size ?size)

   ;; source-dir-prepath(Prepath),source-dir-name(Path).

   (source-dir-prepath ?prepath)

   (source-dir-name ?path)

  ))

 (:antecedent

  ;; cd(Prepath,Path)|

  ((cd ?prepath ?path))

  :consequent
  (
   ;; find-file-by-attr-name-ext(Ext),source-dir-prepath(Prepath),

   (find-file-by-attr-name-ext ?ext)

   (source-dir-prepath ?prepath)

   ;; source-dir-name(Path).

   (source-dir-name ?path)

  ))

 (:antecedent

  ;; ls(Path,Ext)|

  ((ls ?path ?ext))

  :consequent
  (
   ;; find-file-by-attr-name-ext(Ext),source-dir-prepath(Path),file-name(Ext).

   (find-file-by-attr-name-ext ?ext)

   (source-dir-prepath ?path)

   (file-name ?ext)

  ))

 ;; #find a file that begins with arg1

 (:antecedent

  ;; find(Prename,Stem,Size,Prepath,Path)|

  ((find ?prename ?stem ?size ?prepath ?path))

  :consequent
  (
   ;; find-file-by-attr-name-stem(Stem),file-prepath(Prename),

   (find-file-by-attr-name-stem ?stem)

   (file-prepath ?prename)

   ;; file-size(Size),source-dir-prepath(Prepath),source-dir-name(Path).

   (file-size ?size)

   (source-dir-prepath ?prepath)

   (source-dir-name ?path)

  ))

 (:antecedent

  ;; cd(Prepath,Path)|

  ((cd ?prepath ?path))

  :consequent
  (
   ;; find-file-by-attr-name-stem(Stem),source-dir-prepath(Prepath),

   (find-file-by-attr-name-stem ?stem)

   (source-dir-prepath ?prepath)

   ;; source-dir-name(Path).

   (source-dir-name ?path)

  ))

 (:antecedent

  ;; ls(Path,Stem)|

  ((ls ?path ?stem))

  :consequent
  (
   ;; find-file-by-attr-name-stem(Stem),source-dir-prepath(Path),file-name(Stem).

   (find-file-by-attr-name-stem ?stem)

   (source-dir-prepath ?path)

   (file-name ?stem)

  ))

 ;; #find a file that was last modified arg1

 (:antecedent

  ;; cd(Prepath,Path)|

  ((cd ?prepath ?path))

  :consequent
  (
   ;; find-file-by-attr-date-modification-exact(Date),source-dir-prepath(Prepath),

   (find-file-by-attr-date-modification-exact ?date)

   (source-dir-prepath ?prepath)

   ;; source-dir-name(Path).

   (source-dir-name ?path)

  ))

 (:antecedent

  ;; ls(Path,Name)|

  ((ls ?path ?name))

  :consequent
  (
   ;; find-file-by-attr-date-modification-exact(Date),source-dir-prepath(Path),

   (find-file-by-attr-date-modification-exact ?date)

   (source-dir-prepath ?path)

   ;; file-name(Name).

   (file-name ?name)

  ))

 (:antecedent

  ;; egrep(Date,Prepath,Path)|

  ((egrep ?date ?prepath ?path))

  :consequent
  (
   ;; find-file-by-attr-date-modification-exact(Date),file-prepath(Prepath),

   (find-file-by-attr-date-modification-exact ?date)

   (file-prepath ?prepath)

   ;; file-name(Path).

   (file-name ?path)

  ))

 (:antecedent

  ;; fgrep(Date,Prepath,Path)|

  ((fgrep ?date ?prepath ?path))

  :consequent
  (
   ;; find-file-by-attr-date-modification-exact(Date),file-prepath(Prepath),

   (find-file-by-attr-date-modification-exact ?date)

   (file-prepath ?prepath)

   ;; file-name(Path).

   (file-name ?path)

  ))

 (:antecedent

  ;; grep(Date,Prepath,Path)|

  ((grep ?date ?prepath ?path))

  :consequent
  (
   ;; find-file-by-attr-date-modification-exact(Date),file-prepath(Prepath),

   (find-file-by-attr-date-modification-exact ?date)

   (file-prepath ?prepath)

   ;; file-name(Path).

   (file-name ?path)

  ))

 ;; #compress all directories named arg1

 (:antecedent

  ;; compress(Prepath,Dirname)|

  ((compress ?prepath ?dirname))

  :consequent
  (
   ;; compress-dirs-by-attr-name(Dirname),source-dir-prepath(Prepath),

   (compress-dirs-by-attr-name ?dirname)

   (source-dir-prepath ?prepath)

   ;; source-dir-name(Dirname).

   (source-dir-name ?dirname)

  ))

 (:antecedent

  ;; gtar(Destprepath,Destpath,Sourceprepath,Dirname)|

  ((gtar ?destprepath ?destpath ?sourceprepath ?dirname))

  :consequent
  (
   ;; compress-dirs-by-attr-name(Dirname),file-prepath(Destprepath),

   (compress-dirs-by-attr-name ?dirname)

   (file-prepath ?destprepath)

   ;; file-name(Destpath),source-dir-prepath(Sourceprepath),

   (file-name ?destpath)

   (source-dir-prepath ?sourceprepath)

   ;; source-dir-name(Dirname).

   (source-dir-name ?dirname)

  ))

 (:antecedent

  ;; gzip(Prepath,Dirname)|

  ((gzip ?prepath ?dirname))

  :consequent
  (
   ;; compress-dirs-by-attr-name(Dirname),source-dir-prepath(Prepath),

   (compress-dirs-by-attr-name ?dirname)

   (source-dir-prepath ?prepath)

   ;; source-dir-name(Dirname).

   (source-dir-name ?dirname)

  ))

 (:antecedent

  ;; tar(Destprepath,Destpath,Sourceprepath,Dirname)|

  ((tar ?destprepath ?destpath ?sourceprepath ?dirname))

  :consequent
  (
   ;; compress-dirs-by-attr-name(Dirname),file-prepath(Destprepath),

   (compress-dirs-by-attr-name ?dirname)

   (file-prepath ?destprepath)

   ;; file-name(Destpath),source-dir-prepath(Sourceprepath),

   (file-name ?destpath)

   (source-dir-prepath ?sourceprepath)

   ;; source-dir-name(Dirname).

   (source-dir-name ?dirname)

  ))

 (:antecedent

  ;; zip(Destprepath,Destpath,Sourceprepath,Dirname)|

  ((zip ?destprepath ?destpath ?sourceprepath ?dirname))

  :consequent
  (
   ;; compress-dirs-by-attr-name(Dirname),file-prepath(Destprepath),

   (compress-dirs-by-attr-name ?dirname)

   (file-prepath ?destprepath)

   ;; file-name(Destpath),source-dir-prepath(Sourceprepath),

   (file-name ?destpath)

   (source-dir-prepath ?sourceprepath)

   ;; source-dir-name(Dirname).

   (source-dir-name ?dirname)

  ))

 ;; ## compress all subdirectories in directories arg1

 (:antecedent

  ;; compress(Prepath,Dirname)|

  ((compress ?prepath ?dirname))

  :consequent
  (
   ;; compress-dirs-by-loc-dir(Dirname),source-dir-prepath(Prepath),

   (compress-dirs-by-loc-dir ?dirname)

   (source-dir-prepath ?prepath)

   ;; source-dir-name(Dirname).

   (source-dir-name ?dirname)

  ))

 (:antecedent

  ;; gtar(Destprepath,Destpath,Sourceprepath,Dirname)|

  ((gtar ?destprepath ?destpath ?sourceprepath ?dirname))

  :consequent
  (
   ;; compress-dirs-by-loc-dir(Dirname),file-prepath(Destprepath),

   (compress-dirs-by-loc-dir ?dirname)

   (file-prepath ?destprepath)

   ;; file-name(Destpath),source-dir-prepath(Sourceprepath),

   (file-name ?destpath)

   (source-dir-prepath ?sourceprepath)

   ;; source-dir-name(Dirname).

   (source-dir-name ?dirname)

  ))

 (:antecedent

  ;; gzip(Prepath,Dirname)|

  ((gzip ?prepath ?dirname))

  :consequent
  (
   ;; compress-dirs-by-loc-dir(Dirname),source-dir-prepath(Prepath),

   (compress-dirs-by-loc-dir ?dirname)

   (source-dir-prepath ?prepath)

   ;; source-dir-name(Dirname).

   (source-dir-name ?dirname)

  ))

 (:antecedent

  ;; tar(Destprepath,Destpath,Sourceprepath,Dirname)|

  ((tar ?destprepath ?destpath ?sourceprepath ?dirname))

  :consequent
  (
   ;; compress-dirs-by-loc-dir(Dirname),file-prepath(Destprepath),

   (compress-dirs-by-loc-dir ?dirname)

   (file-prepath ?destprepath)

   ;; file-name(Destpath),source-dir-prepath(Sourceprepath),

   (file-name ?destpath)

   (source-dir-prepath ?sourceprepath)

   ;; source-dir-name(Dirname).

   (source-dir-name ?dirname)

  ))

 (:antecedent

  ;; zip(Destprepath,Destpath,Sourceprepath,Dirname)|

  ((zip ?destprepath ?destpath ?sourceprepath ?dirname))

  :consequent
  (
   ;; compress-dirs-by-loc-dir(Dirname),file-prepath(Destprepath),

   (compress-dirs-by-loc-dir ?dirname)

   (file-prepath ?destprepath)

   ;; file-name(Destpath),source-dir-prepath(Sourceprepath),

   (file-name ?destpath)

   (source-dir-prepath ?sourceprepath)

   ;; source-dir-name(Dirname).

   (source-dir-name ?dirname)

  ))

 ;; ##find out how much file space file arg1 uses

 (:antecedent

  ;; ls(Path,Filename)|

  ((ls ?path ?filename))

  :consequent
  (
   ;; know-filespace-usage-file(Filename),file-name(Filename),

   (know-filespace-usage-file ?filename)

   (file-name ?filename)

   ;; file-prepath(Path).

   (file-prepath ?path)

  ))

 (:antecedent

  ;; du(Prepath,Partition-name)|

  ((du ?prepath ?partition-name))

  :consequent
  (
   ;; know-filespace-usage-partition(Partition-name),

   (know-filespace-usage-partition ?partition-name)

   ;; source-dir-name(Partition-name),source-dir-prepath(Prepath).

   (source-dir-name ?partition-name)

   (source-dir-prepath ?prepath)

  ))

 ;; ##find out how much file space is free on filesystem arg1

 (:antecedent

  ;; df(Prepath,Partition-name)|

  ((df ?prepath ?partition-name))

  :consequent
  (
   ;; know-filespace-free(Partition-name),

   (know-filespace-free ?partition-name)

   ;; source-dir-name(Partition-name),source-dir-prepath(Prepath).

   (source-dir-name ?partition-name)

   (source-dir-prepath ?prepath)

  ))

 ;; ##find out if machine arg1 is alive on the network on not

 (:antecedent

  ;; ping(Machine-name,Machine-path)|

  ((ping ?machine-name ?machine-path))

  :consequent
  (
   ;; determine-machine-connected-alive(Machine-name),

   (determine-machine-connected-alive ?machine-name)

   ;; machine-prepath(Machine-path).

   (machine-prepath ?machine-path)

  ))

 (:antecedent

  ;; ruptime(Machine-name)|

  ((ruptime ?machine-name))

  :consequent
  (
   ;; determine-machine-connected-alive(Machine-name).

   (determine-machine-connected-alive ?machine-name)

  ))

 (:antecedent

  ;; rsh(Machine-name,Command)|

  ((rsh ?machine-name ?command))

  :consequent
  (
   ;; determine-machine-connected-alive(Machine-name).

   (determine-machine-connected-alive ?machine-name)

  ))

 (:antecedent

  ;; rlogin(Machine-name)|

  ((rlogin ?machine-name))

  :consequent
  (
   ;; determine-machine-connected-alive(Machine-name).

   (determine-machine-connected-alive ?machine-name)

  ))

 ;; ##create a file named arg1 in a preexisting directory named arg2

 (:antecedent

  ;; cd(Prepath,Dirname)|

  ((cd ?prepath ?dirname))

  :consequent
  (
   ;; create-file(Filename,Dirname),file-name(Filename),source-dir-name(Dirname),

   (create-file ?filename ?dirname)

   (file-name ?filename)

   (source-dir-name ?dirname)

   ;; source-dir-prepath(Prepath).

   (source-dir-prepath ?prepath)

  ))

 (:antecedent

  ;; vi(Prepath,Filename)|

  ((vi ?prepath ?filename))

  :consequent
  (
   ;; create-file(Filename,Prepath),file-name(Filename),source-dir-name(Prepath).

   (create-file ?filename ?prepath)

   (file-name ?filename)

   (source-dir-name ?prepath)

  ))

 (:antecedent

  ;; cat(Prepath,Filename)|

  ((cat ?prepath ?filename))

  :consequent
  (
   ;; create-file(Filename,Prepath),file-name(Filename),source-dir-name(Prepath).

   (create-file ?filename ?prepath)

   (file-name ?filename)

   (source-dir-name ?prepath)

  ))

 (:antecedent

  ;; touch(Prepath,Filename)|

  ((touch ?prepath ?filename))

  :consequent
  (
   ;; create-file(Filename,Prepath),source-dir-name(Prepath),file-name(Filename).

   (create-file ?filename ?prepath)

   (source-dir-name ?prepath)

   (file-name ?filename)

  ))

 ;; ##create a subdirectory named arg1 in a preexisting directory named arg2

 (:antecedent

  ;; mkdir(Dirname,Parent-dir-name)|

  ((mkdir ?dirname ?parent-dir-name))

  :consequent
  (
   ;; create-dir(Dirname,Parent-dir-name),source-dir-name(Parent-dir-name),

   (create-dir ?dirname ?parent-dir-name)

   (source-dir-name ?parent-dir-name)

   ;; dir-name(Dirname).

   (dir-name ?dirname)

  ))

 (:antecedent

  ;; cd(Prepath,Parent-dir-name)|

  ((cd ?prepath ?parent-dir-name))

  :consequent
  (
   ;; create-dir(Dirname,Parent-dir-name),source-dir-name(Parent-dir-name),

   (create-dir ?dirname ?parent-dir-name)

   (source-dir-name ?parent-dir-name)

   ;; source-dir-prepath(Prepath),dir-name(Dirname).

   (source-dir-prepath ?prepath)

   (dir-name ?dirname)

  ))

 ;; ##delete all files ending in arg1

 (:antecedent

  ;; rm(Prepath,Ext)|

  ((rm ?prepath ?ext))

  :consequent
  (
   ;; remove-files-by-attr-name-ext(Ext),file-name(Ext),file-prepath(Prepath).

   (remove-files-by-attr-name-ext ?ext)

   (file-name ?ext)

   (file-prepath ?prepath)

  ))

 ;; ##delete all files which contain more than arg1 bytes

 (:antecedent

  ;; rm(Prepath,Name)|

  ((rm ?prepath ?name))

  :consequent
  (
   ;; remove-files-by-attr-size-gt(Numbytes),file-size(Numbytes),file-prepath(Prepath),

   (remove-files-by-attr-size-gt ?numbytes)

   (file-size ?numbytes)

   (file-prepath ?prepath)

   ;; file-name(Name).

   (file-name ?name)

  ))

 ;; ## copy all files ending in arg1 to a preexisting directory named arg2

 (:antecedent

  ;; cp(Dest-prepath,Dirname,Source-prepath,Ext)|

  ((cp ?dest-prepath ?dirname ?source-prepath ?ext))

  :consequent
  (
   ;; copy-files-by-attr-name-ext(Ext,Dirname),file-name(Ext),

   (copy-files-by-attr-name-ext ?ext ?dirname)

   (file-name ?ext)

   ;; dest-dir-prepath(Prepath),dest-dir-name(Dirname),file-prepath(Source-prepath).

   (dest-dir-prepath ?prepath)

   (dest-dir-name ?dirname)

   (file-prepath ?source-prepath)

  ))

 ;; ##copy all files containing less than arg1 bytes to a preexisting directory names arg2

 (:antecedent

  ;; cp(Dest-prepath,Dirname,Source-prepath,Name)|

  ((cp ?dest-prepath ?dirname ?source-prepath ?name))

  :consequent
  (
   ;; copy-files-by-attr-size-lt(Numbytes,Dirname),filesize(Numbytes),

   (copy-files-by-attr-size-lt ?numbytes ?dirname)

   (filesize ?numbytes)

   ;; dest-dir-name(Dirname),dest-dir-prepath(Dest-prepath),

   (dest-dir-name ?dirname)

   (dest-dir-prepath ?dest-prepath)

   ;; file-prepath(Source-prepath),file-name(Name).

   (file-prepath ?source-prepath)

   (file-name ?name)

  ))

 ;; ## move all files ending in arg1 to a preexisting directory named arg2

 (:antecedent

  ;; mv(Dest-prepath,Dirname,Source-prepath,Ext)|

  ((mv ?dest-prepath ?dirname ?source-prepath ?ext))

  :consequent
  (
   ;; move-files-by-attr-name-ext(Ext,Dirname),file-name(Ext),

   (move-files-by-attr-name-ext ?ext ?dirname)

   (file-name ?ext)

   ;; file-prepath(Source-prepath),dest-dir-name(Dirname),

   (file-prepath ?source-prepath)

   (dest-dir-name ?dirname)

   ;; dest-dir-prepath(Dest-prepath).

   (dest-dir-prepath ?dest-prepath)

  ))

 (:antecedent

  ;; copy-files-by-attr-name-ext(Ext,Dirname)|

  ((copy-files-by-attr-name-ext ?ext ?dirname))

  :consequent
  (
   ;; move-files-by-attr-name-ext(Ext,Dirname),file-name(Ext),dest-dir-name(Dirname).

   (move-files-by-attr-name-ext ?ext ?dirname)

   (file-name ?ext)

   (dest-dir-name ?dirname)

  ))

 (:antecedent

  ;; remove-files-by-attr-name-ext(Ext)|

  ((remove-files-by-attr-name-ext ?ext))

  :consequent
  (
   ;; move-files-by-attr-name-ext(Ext,Dirname),file-name(Ext),dest-dir-name(Dirname).

   (move-files-by-attr-name-ext ?ext ?dirname)

   (file-name ?ext)

   (dest-dir-name ?dirname)

  ))

 ;; ## move all files beginning with arg1 to a preexisting directory named arg2

 (:antecedent

  ;; mv(Dest-prepath,Dirname,Source-prepath,Stem)|

  ((mv ?dest-prepath ?dirname ?source-prepath ?stem))

  :consequent
  (
   ;; move-files-by-attr-name-stem(Stem,Dirname),file-name(Stem),

   (move-files-by-attr-name-stem ?stem ?dirname)

   (file-name ?stem)

   ;; dest-dir-name(Dirname),file-prepath(Source-prepath),

   (dest-dir-name ?dirname)

   (file-prepath ?source-prepath)

   ;; dest-dir-prepath(Dest-prepath).

   (dest-dir-prepath ?dest-prepath)

  ))

 (:antecedent

  ;; cp(Dest-prepath,Dirname,Source-prepath,Stem)|

  ((cp ?dest-prepath ?dirname ?source-prepath ?stem))

  :consequent
  (
   ;; move-files-by-attr-name-stem(Stem,Dirname),file-name(Stem),

   (move-files-by-attr-name-stem ?stem ?dirname)

   (file-name ?stem)

   ;; dest-dir-name(Dirname),file-prepath(Source-prepath),

   (dest-dir-name ?dirname)

   (file-prepath ?source-prepath)

   ;; dest-dir-prepath(Dest-prepath).

   (dest-dir-prepath ?dest-prepath)

  ))

 (:antecedent

  ;; rm(Source-prepath,Stem)|

  ((rm ?source-prepath ?stem))

  :consequent
  (
   ;; move-files-by-attr-name-stem(Stem,Dirname),file-name(Stem),

   (move-files-by-attr-name-stem ?stem ?dirname)

   (file-name ?stem)

   ;; dest-dir-name(Dirname),file-prepath(Source-prepath).

   (dest-dir-name ?dirname)

   (file-prepath ?source-prepath)

  ))

 ;; ## move all files containing less than arg1 bytes to a preexisting directory

 (:antecedent

  ;; mv(Dest-prepath,Dirname,Source-prepath,Name)|

  ((mv ?dest-prepath ?dirname ?source-prepath ?name))

  :consequent
  (
   ;; move-files-by-attr-size-lt(Num-bytes,Dirname),file-size(Num-bytes),

   (move-files-by-attr-size-lt ?num-bytes ?dirname)

   (file-size ?num-bytes)

   ;; dest-dir-name(Dirname),file-name(Name),file-prepath(Source-prepath),

   (dest-dir-name ?dirname)

   (file-name ?name)

   (file-prepath ?source-prepath)

   ;; dest-dir-prepath(Dest-prepath).

   (dest-dir-prepath ?dest-prepath)

  ))

 (:antecedent

  ;; cp(Dest-prepath,Dirname,Source-prepath,Name)|

  ((cp ?dest-prepath ?dirname ?source-prepath ?name))

  :consequent
  (
   ;; move-files-by-attr-size-lt(Num-bytes,Dirname),file-size(Num-bytes),

   (move-files-by-attr-size-lt ?num-bytes ?dirname)

   (file-size ?num-bytes)

   ;; dest-dir-name(Dirname),file-name(Name),file-prepath(Source-prepath),

   (dest-dir-name ?dirname)

   (file-name ?name)

   (file-prepath ?source-prepath)

   ;; dest-dir-prepath(Dest-prepath).

   (dest-dir-prepath ?dest-prepath)

  ))

 (:antecedent

  ;; rm(Source-prepath,Name)|

  ((rm ?source-prepath ?name))

  :consequent
  (
   ;; move-files-by-attr-size-lt(Num-bytes,Dirname),file-size(Num-bytes),

   (move-files-by-attr-size-lt ?num-bytes ?dirname)

   (file-size ?num-bytes)

   ;; dest-dir-name(Dirname),file-name(Name),file-prepath(Source-prepath).

   (dest-dir-name ?dirname)

   (file-name ?name)

   (file-prepath ?source-prepath)

  ))

)
