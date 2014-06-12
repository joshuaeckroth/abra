(setq *cases*

  (list

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "pl"))
     :evidence
     '((ls "_" "**dot_0**")
      (rm "_" "pl")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "linux")
      (ls "_" "**dot_2**")
      (cd "_" "gang")
      (ls "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (cd "_" "**dotdot_4**")
      (ls "_" "**dot_5**")
      (cd "_" "**dotdot_5**")
      (ls "_" "**dot_6**")
      (cd "_" "code")
      (ls "_" "**dot_7**")
      (cd "_" "**dotdot_7**")
      (cd "_" "mail")
      (ls "_" "**dot_9**")
      (cd "_" "2")
      (ls "_" "**dot_10**")
      (cd "_" "mickey")
      (ls "_" "**dot_11**")
      (cd "_" "**dotdot_11**")
      (cd "_" "set")
      (ls "_" "**dot_13**")
      (cd "_" "**dotdot_13**")
      (ls "_" "**dot_14**")
      (cd "_" "**dotdot_14**")
      (ls "_" "**dot_15**")
      (cd "_" "dwarf")
      (ls "_" "**dot_16**")
      (cd "_" "gang")
      (ls "_" "**dot_17**")
      (cd "_" "**dotdot_17**")
      (ls "_" "**dot_18**")
      (cd "_" "true")
      (ls "_" "**dot_19**")
      (cd "_" "**dotdot_19**")
      (ls "_" "**dot_20**")
      (cd "_" "**dotdot_20**")
      (ls "_" "**dot_21**")
      (cd "_" "gag")
      (cd "_" "gang")
      (ls "_" "**dot_23**")
      (cd "_" "3")
      (ls "_" "**dot_24**")
      (cd "_" "**dotdot_24**")
      (cd "_" "dwarf")
      (ls "_" "**dot_26**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "gang")
      (cd "_" "**dotdot_2**")
      (tar "_" "-" "_" "gang")
      (tar "_" "-" "_" "gang")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "code")
      (ls "_" "**dot_5**")
      (cd "_" "**dotdot_5**")
      (cd "_" "mail")
      (ls "_" "**dot_7**")
      (tar "_" "-" "_" "gang")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "3")
      (ls "_" "**dot_2**")
      (cd "_" "**dotdot_2**")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "code")
      (ls "_" "**dot_5**")
      (cd "_" "dwarf")
      (ls "_" "**dot_6**")
      (tar "_" "-" "_" "gang")
      (cd "_" "**dotdot_6**")
      (cd "_" "**dotdot_7**")
      (ls "_" "**dot_8**")
      (cd "_" "mail")
      (ls "_" "**dot_9**")
      (cd "_" "2")
      (ls "_" "**dot_10**")
      (cd "_" "intro")
      (ls "_" "**dot_11**")
      (cd "_" "**dotdot_11**")
      (cd "_" "set")
      (ls "_" "**dot_13**")
      (cd "_" "**dotdot_13**")
      (cd "_" "**dotdot_14**")
      (ls "_" "**dot_15**")
      (cd "_" "dwarf")
      (ls "_" "**dot_16**")
      (cd "_" "**dotdot_16**")
      (cd "_" "mickey")
      (ls "_" "**dot_18**")
      (tar "_" "-" "_" "gang")
      (cd "_" "true")
      (ls "_" "**dot_19**")
      (cd "_" "**dotdot_19**")
      (cd "_" "**dotdot_20**")
      (ls "_" "**dot_21**")
      (cd "_" "**dotdot_21**")
      (ls "_" "**dot_22**")
      (cd "_" "code")
      (ls "_" "**dot_23**")
      (cd "_" "dwarf")
      (ls "_" "**dot_24**")
      (cd "_" "**dotdot_24**")
      (cd "_" "linux")
      (ls "_" "**dot_26**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "README")
      (cd "bin" "linux")
      (ls "_" "**dot_1**")
      (find "_" "_" "_" "_" "**dot_1**" "_" "find(" "_" "_" "_" "REAME")
      (find "_" "_" "_" "_" "**dot_1**" "_" "find(" "_" "_" "_" "README")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "gang"))
     :evidence
     '((find "_" "_" "_" "_" "gang")
      (find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "gang")
      (cd "bin" "mickey")
      (ls "_" "**dot_1**")
      (tar "_" "-" "_" "gang")
      (cd "_" "**dotdot_1**")
      (cd "_" "**dotdot_2**")
      (ls "_" "**dot_3**")
      (cd "_" "mail")
      (ls "_" "**dot_4**")
      (tar "_" "-" "_" "gang")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "gang")
      (ls "_" "**dot_2**")
      (tar "_" "dwarf.tar.gz" "_" "dwarf")
      (tar "_" "dwarf.tar.gz" "_" "dwarf")
      (cd "_" "**dotdot_2**")
      (ls "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "code")
      (ls "_" "**dot_5**")
      (cd "_" "gang")
      (ls "_" "**dot_6**")
      (tar "_" "dwarf.tar.gz" "_" "dwarf")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (cd "_" "code")
      (cd "_" "gang")
      (ls "_" "**dot_4**")
      (tar "_" "gang.tar.gz" "_" "gang")
      (cd "_" "**dotdot_4**")
      (ls "_" "**dot_5**")
      (tar "_" "gang.tar.gz" "_" "gang")
      (cd "_" "**dotdot_5**")
      (cd "_" "mail")
      (ls "_" "**dot_7**")
      (cd "_" "dwraf")
      (cd "_" "dwarf")
      (ls "_" "**dot_9**")
      (tar "_" "gang.tar.gz" "_" "gang")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "canberra"))
     :evidence
     '((ping "canberra" "_")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "ps14.txt"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (ls "_" "ps14.txt")
      (find "_" "ps14.txt" "_" "_" "**dot_0**")
      (ls "./code/2/true" "ps14.txt")
      (cat "./code/2/true" "ps14.txt")
      (ls "./code/2/true" "ps14.txt")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "pl"))
     :evidence
     '((find "_" "pl" "_" "_" "**dot_0**")
      (find "_" "pl" "_" "_" "**dot_0**")
      (rm "code/gang" "constructor.pl")
      (rm "code/intro" "aml.pl")
      (rm "code/set" "convert.pl")
      (rm "mail/true/dwarf" "accessor.pl")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((find "_" "libtool" "_" "_" "**dot_0**")
      (find "_" "libtool" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "gang"))
     :evidence
     '((find "_" "aml" "_" "_" "**dot_0**")
      (find "_" "aml" "_" "_" "**dot_0**")
      (man "find")
      (find "_" "_" "_" "_" "**dot_0**")
      (mv "/mail" "gang" "/mail/gang/intro" "aml")
      (mv "_" "mail.gang" "mail/gang/intro" "aml")
      (mv "mail" "gang" "mail/gang/intro" "aml")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (mv "_" "dwarf" "_" "ps")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "**dotdot_1**" "code")
      (ls "_" "**dot_2**")
      (ls "_" "rl.exe")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "dwarf"))
     :evidence
     '((cd "_" "doce")
      (cd "_" "code")
      (ls "_" "**dot_2**")
      (cd "**dotdot_2**" "bin")
      (ls "_" "**dot_3**")
      (cd "**dotdot_3**" "mail")
      (ls "_" "**dot_4**")
      (mv "_" "dwarf" "../bin" "pl")
      (ls "_" "dwarf")
      (cd "_" "**dotdot_4**")
      (ls "_" "**dot_5**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "*" "**dot_0**")
      (ls "*/*" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-dir "egg_salad.exe" "gang"))
     :evidence
     '((cd "mail" "gang")
      (cd "_" "mail")
      (ls "_" "**dot_2**")
      (cd "_" "**dotdot_2**")
      (ls "_" "**dot_3**")
      (cd "_" "code")
      (ls "_" "**dot_4**")
      (cd "**dotdot_4**" "bin")
      (ls "_" "**dot_5**")
      (ls "*" "**dot_5**")
      (cd "intro/2" "gang")
      (ls "_" "**dot_6**")
      (mkdir "_" "egg_salad.exe")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "gang" "_" "_" "**dot_0**")
      (cd "code" "set")
      (cd "_" "gang")
      (ls "_" "**dot_2**")
      (tar "_" "gang1.tar" "_" "**dot_2**")
      (gzip "_" "gang1.tar")
      (mv "_" "greg.tar" "_" "gang1.tar")
      (ls "_" "**dot_2**")
      (mv "_" "greg.tar.gz" "_" "ga1.tar.gz")
      (mv "_" "greg.tar.gz" "_" "gang1.tar.gz")
      (cd "../../code" "gang")
      (cd "../.." "gang")
      (tar "_" "gang.tar" "_" "**dot_4**")
      (gzip "_" "gang.tar")
      (cd "../../mail/dwarf" "gang")
      (tar "_" "gang.tar" "_" "**dot_5**")
      (gzip "_" "gang.tar")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "dorito.csug.rochester.edu:/var/mail"))
     :evidence
     '((less "/etc" "fstab")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (cd "bin" "gang")
      (ls "_" "**dot_1**")
      (tar "_" "set.tar" "_" "set")
      (gzip "_" "set.tar")
      (cd "../../code" "gang")
      (ls "_" "**dot_2**")
      (cd "../../mail/linux" "gang")
      (ls "_" "**dot_3**")
      (tar "_" "intro.tar" "_" "intro")
      (gzip "_" "intro.tar")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "5.5"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-size-gt "40000"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (ls "_" "**dot_1**")
      (ls "_" "mickey")
      (cd "_" "**dotdot_1**")
      (ls "_" "code")
      (ls "code" "dwarf")
      (ls "code/dwarf" "gang")
      (ls "code/dwarf" "linux")
      (ls "code" "linux")
      (rm "code/linux" "chapin-research.ps")
      (ls "code/dwarf/linux" "dwarf")
      (ls "code/linux" "dwarf")
      (ls "code/linux/dwarf" "3")
      (ls "code/linux" "true")
      (ls "_" "mail")
      (ls "mail" "2")
      (ls "mail/2" "gang")
      (ls "mail" "gang")
      (rm "mail/gang" "aslisp1.ps")
      (ls "mail/gang" "intro")
      (ls "mail/gang" "set")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (cd "mail" "dwarf")
      (touch "_" "joe.txt")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Feb21"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "bin" "gang")
      (ls "bin/gang" "dwarf")
      (ls "bin/gang/dwarf" "gang")
      (ls "bin" "mickey")
      (ls "_" "code")
      (ls "code" "true")
      (ls "_" "mail")
      (ls "mail" "2")
      (ls "mail/2" "dwarf")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((find "_" "c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "pl"))
     :evidence
     '((find "_" "pl" "_" "_" "**dot_0**")
      (rm "bin/dwarf" "convert.pl")
      (rm "bin/dwarf/2" "constructor.pl")
      (rm "bin/dwarf/2/true" "aml.pl")
      (rm "code" "accessor.pl")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "linux"))
     :evidence
     '((find "_" "pl" "_" "_" "**dot_0**")
      (mv "mail" "linux" "bin/intro/gang" "convert.pl" "_" "mv(mail" "linux" "code/dwarf" "constructor.pl" "_" "mv(mail" "linux" "code/set" "accessor.pl")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((find "_" "b.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "bin" "3")
      (ls "bin/3" "2")
      (ls "bin/3/2" "gang")
      (ls "bin/3" "gang")
      (ls "_" "code")
      (ls "code" "intro")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "mail/dwarf/gang" "linux" "code/intro" "5.5.aux")
      (ls "code" "true")
      (ls "code/true" "set")
      (ls "_" "mail")
      (ls "mail" "dwarf")
      (ls "mail/dwarf" "dwarf")
      (ls "mail/dwarf" "gan")
      (ls "mail/dwarf" "gang")
      (ls "mail/dwarf/gang" "linux")
      (ls "mail/dwarf" "mickey")
      (mv "mail/dwarf/gang" "linux" "mail/dwarf/mickey" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "linux"))
     :evidence
     '((find "_" "aml" "_" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "code/set" "linux" "code/gang/gang" "aml")
      (mv "code/set" "linux" "mail/3" "aml")
      ))

   (make-exp-case
     :groundtruth '((create-dir "s2" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (cd "bin/gang" "linux")
      (mkdir "_" "s2")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Mar21"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "2"))
     :evidence
     '((find "_" "2" "_" "_" "**dot_0**")
      (cd "mail" "2")
      (ls "_" "**dot_1**")
      (tar "_" "mickey.tar" "_" "mickey")
      (gzip "_" "mickey.tar")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((find "_" "c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "bin" "2")
      (ls "bin/2" "mickey")
      (ls "bin" "3")
      (ls "bin" "dwarf")
      (ls "bin/dwarf" "intro")
      (ls "bin/dwarf" "set")
      (ls "bin" "gang")
      (ls "bin/gang" "dwarf")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "code" "linux" "bin/gang/dwarf" "5")
      (ls "bin/gang/dwarf" "gang")
      (ls "bin/gang/dwarf/gang" "gang")
      (ls "_" "code")
      (ls "_" "linux")
      (ls "code" "linux")
      (ls "_" "mail")
      (mv "code" "linux" "_" "capture.txt")
      (mv "code" "linux" "mail" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((find "_" "rl.exe" "_" "_" "**dot_0**")
      (du "mail" "rl.exe")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (cd "bin/dwarf" "gang")
      (ls "_" "**dot_1**")
      (cd "../../../code/dwarf" "gang")
      (ls "_" "**dot_2**")
      (cd "../../../mail/set" "gang")
      (ls "_" "**dot_3**")
      (tar "_" "true.tar" "_" "true")
      (gzip "_" "true.tar")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (touch "code/dwarf/linux" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "dwarf"))
     :evidence
     '((find "_" "eps" "_" "_" "**dot_0**")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (mv "bin/intro" "dwarf" "code/gang" "agent.eps")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "dorito.csug.rochester.edu:/var/mail"))
     :evidence
     '((cat "/etc" "fstab")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "dwarf"))
     :evidence
     '((find "_" "eps" "_" "_" "**dot_0**")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (mv "bin/intro" "dwarf" "code/gang" "agent.eps")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "maputo"))
     :evidence
     '((ruptime "_")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (ls "./bin/dwarf" "gang")
      (compress "./bin/dwarf/gang" "dwarf")
      (compress "./bin" "dwarf")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (compress "./bin/gang" "**dot_0**")
      (compress "./mail/gang" "**dot_0**")
      (uncompress "./mail/gang" "**dot_0**")
      (compress "./mail/gang/gang" "**dot_0**")
      (compress "./mail/gang" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((find "_" "b.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "README" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (touch "./code/true/dwarf" "joe.txt")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "linux"))
     :evidence
     '((find "_" "eps" "_" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "./bin" "linux" "./code" "agent.eps")
      (find "_" "eps" "_" "_" "**dot_0**" "_" "find(" "eps" "_" "_" "print")
      (find "_" "eps" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "gang"))
     :evidence
     '((find "_" "aml" "_" "_" "**dot_0**")
      (find "_" "gang" "_" "_" "**dot_0**")
      (mv "./bin" "gang" "./bin/dwarf/true" "aml.pl")
      (mv "./bin" "gang" "./code" "aml.config")
      (ls "./bin" "gang")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "README" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (cd "mail/gang/gang" "linux")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (cd "_" "**dotdot_2**")
      (pwd "_")
      (cd "**dotdot_3**" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (find "_" "_" "38400" "_" "**dot_4**")
      (find "_" "_" "38400" "_" "**dot_4**")
      (find "_" "_" "75" "_" "**dot_4**")
      (find "_" "linux" "_" "_" "**dot_4**")
      (mv "./mail/gang/gang" "linux" "./bin/dwarf" "capture.txt" "_" "mv(./mail/gang/gang" "linux" "./mail/set" "5.5.aux")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "linux"))
     :evidence
     '((find "_" "_" "50" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "./code" "linux" "./code/mickey/2/intro" "5.5.aux" "_" "mv(./code" "linux" "./code/mickey/gang" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "slate.cs.rochester.edu:/var/mail"))
     :evidence
     '((df "/var" "mail")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (find "_" "_" "75" "_" "**dot_0**")
      (ln "./code" "dwarf" "./bin/mickey/dwarf" "5.5.aux" "_" "ln(./code" "dwarf" "./code/gang" "capture.txt")
      (mv "./bin/mickey" "dwarf" "./bin/mickey/dwarf" "5.5.aux" "_" "mv(./bin/mickey" "dwarf" "./code/gang" "capture.txt")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (find "_" "_" "75" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "ps14.txt"))
     :evidence
     '((ls "_" "ps14.txt")
      (find "_" "ps14.txt" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Jan21"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "code/true" "aslisp1.ps")
      (ls "code" "blaylock.jpg")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (find "_" "pl" "_" "_" "**dot_0**")
      (mv "./mail/2/dwarf" "linux" "./mail" "accessor.pl" "_" "mv(./mail/2/dwarf" "linux" "./mail/gang" "convert.pl" "_" "mv(./mail/2/dwarf" "linux" "./mail/3" "aml.pl" "_" "mv(./mail/2/dwarf" "linux" "./mail/2" "constructor.pl")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((find "_" "c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((find "_" "b.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "maputo"))
     :evidence
     '((ping "maputo" "_")
      (ruptime "_")
      (rsh "maputo" "uptime")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "2"))
     :evidence
     '((find "_" "2" "_" "_" "**dot_0**")
      (cd "bin/linux" "2")
      (ls "_" "**dot_1**")
      (du "_" "**dot_1**")
      (gtar "_" "3.tgz" "_" "3")
      (rm "_" "3")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-size-gt "50000"))
     :evidence
     '((find "_" "_" "50000" "_" "**dot_0**")
      (rm "./code/gang" "chapin-research.ps" "_" "rm(./mail" "aslisp1.ps")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (find "_" "_" "50" "_" "**dot_0**")
      (mv "./mail" "dwarf" "./code/set/intro/2/gang" "5.5.aux" "_" "mv(./mail" "dwarf" "./mail" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "_" "code")
      (ls "_" "mail")
      (cd "_" "bin")
      (mv "_" "gang" "_" "aml")
      (ls "_" "**dot_1**")
      (ls "_" "**dotdot_1**")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (ls "_" "mail")
      (ls "_" "code")
      (cd "_" "code")
      (ls "_" "**dot_3**")
      (mv "_" "gang" "_" "aml")
      (ls "_" "**dot_3**")
      (cd "**dotdot_3**" "mai")
      (cd "**dotdot_4**" "mail")
      (ls "_" "**dot_5**")
      (ls "_" "**dot_5**")
      (ls "_" "**dotdot_5**")
      (ls "**dotdot_5**" "bin")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (ls "_" "arf")
      (ls "_" "dwarf")
      (ls "_" "true")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (ls "_" "bin")
      (cd "_" "code")
      (ls "_" "**dot_3**")
      (ls "_" "dwarf")
      (ls "_" "true")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (ls "_" "mail")
      (ls "_" "bin")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "canberra"))
     :evidence
     '((ping "canberra" "_")
      ))

   (make-exp-case
     :groundtruth '((create-dir "s2" "gang"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "name" "_" "find(" "_" "_" "_" "gang")
      (cd "bin" "gang")
      (mkdir "_" "s2")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "_" "code")
      (ls "_" "mail")
      (ls "mail" "linux")
      (ls "mail/lix" "intro")
      (ls "mail/linux" "intro")
      (ls "_" "bin")
      (ls "bin" "dwarf")
      (ls "bin/dwarf" "dwarf")
      (ls "bin/dwarf" "gang")
      (ls "_" "**dot_0**")
      (ls "_" "code")
      (ls "code" "gang")
      (ls "code" "set")
      (mv "bin" "dwarf" "code/set" "convert.pl")
      (ls "bin" "dwarf")
      (ls "code" "set")
      (ls "code/set" "gang")
      (ls "code/set/gang" "true")
      (ls "_" "code")
      (ls "code" "set")
      (ls "_" "bin")
      ))

   (make-exp-case
     :groundtruth '((create-dir "my_thesis.txt" "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      (cd "mail" "gang")
      (mkdir "_" "my_thesis.txt")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "2"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      (cd "bin" "2")
      (tar "_" "gang.tar" "gang" "**dot_1**")
      (gzip "_" "gang.tar")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "amsterdam"))
     :evidence
     '((ping "amsterdam" "_")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      (grep "libtool" "_" "foo")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((find "_" "c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Jan21"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (ls "_" "bin")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "dwarf"))
     :evidence
     '((ls "_" "bin")
      (ls "_" "**dot_0**")
      (ls "_" "code")
      (ls "_" "mail")
      (mv "mail" "dwarf" "mail" "5.5.aux")
      (ls "bin" "linux")
      (ls "bin/linux" "3")
      (ls "code" "2")
      (ls "code/2/gang" "mickey")
      (ls "code/2" "gang")
      (ls "code/2/gang" "sest")
      (ls "code/2/gang" "set")
      (ls "code/2" "mickey")
      (ls "code" "dwarf")
      (ls "code" "gang")
      (ls "code" "intro")
      (ls "mail" "dwarf")
      (ls "mail/dwarf" "gang")
      (ls "mail/dwarf" "true")
      (mv "mail" "dwarf" "mail/dwarf/true" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((create-dir "egg_salad.exe" "2"))
     :evidence
     '((find "_" "2" "_" "_" "**dot_0**")
      (mkdir "bin/2" "egg_salad.exe")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (tar "_" "bin_dwarf_gang.tar.gz" "bin/dwarf" "gang")
      (tar "_" "mail_linux_gang.tar.gz" "mail/linux" "gang")
      (tar "_" "mail_linux_gang_gang.tar.gz" "mail/linux/gang" "gang")
      (ls "_" "*tar.gz")
      ))

   (make-exp-case
     :groundtruth '((copy-files-by-attr-size-lt "100" "linux"))
     :evidence
     '((find "_" "_" "100" "_" "**dot_0**")
      (find "_" "_" "1" "_" "**dot_0**")
      (cp "mail" "linux" "mail/dwarf/mickey" "d.c" "_" "cp(mail" "linux" "mail/dwarf/gang/3" "capture.txt" "_" "cp(mail" "linux" "mail/dwarf/gang" "c.c" "_" "cp(mail" "linux" "mail/dwarf/gang" "cas.c" "_" "cp(mail" "linux" "mail" "5.5.aux" "_" "cp(mail" "linux" "code/dwarf/2/gang" "a.c" "_" "cp(mail" "linux" "code/dwarf/2/gang" "b.c" "_" "cp(mail" "linux" "code/dwarf/true" "greq.ggd")
      (cp "mail" "linux" "code/dwarf/2" "b.c")
      (ls "mail" "linux")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "mickey"))
     :evidence
     '((find "_" "mickey" "_" "_" "**dot_0**")
      (tar "_" "mail_dwarf_mickey.tar.gz" "mail/dwarf" "mickey")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((find "_" "rl.exe" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((find "_" "c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((df "/home/vax1" "u")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (tar "_" "bin_gang.tar.gz" "bin" "gang")
      (tar "_" "bin_gang_gang.tar.gz" "bin/gang" "gang")
      (tar "_" "mail_dwarf_gang.tar.gz" "mail/dwarf" "gang")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-size-gt "50000"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "bin" "2")
      (ls "bin/2" "linux")
      (ls "bin" "dwarf")
      (ls "bin/dwarf" "3")
      (ls "bin/dwarf" "set")
      (ls "/bin" "gang")
      (ls "bin" "gang")
      (ls "bin/gang" "gang")
      (ls "bin/gang" "true")
      (rm "bin/gang/true" "aslisp1.ps")
      (ls "bin" "intro")
      (ls "bin/intro" "gang")
      (ls "_" "code")
      (ls "code" "mickey")
      (ls "_" "mail")
      (ls "mail" "dwarf")
      (rm "mail/dwarf" "chapin-research.ps")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-size-gt "40000"))
     :evidence
     '((find "_" "_" "40960" "_" "**dot_0**")
      (rm "mail/dwarf/gang/2/3" "cycle.tiff")
      (rm "mail/intro/dwarf" "aslisp1.ps")
      (rm "mail/intro/dwarf" "chapin-research.ps")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (touch "bin/true/dwarf" "joe.txt")
      ))

   (make-exp-case
     :groundtruth '((copy-files-by-attr-size-lt "50" "linux"))
     :evidence
     '((find "_" "_" "50" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (cp "bin" "linux" "bin/linux" "5.5.aux" "_" "cp(bin" "linux" "mail/gang/set" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "ps14.txt"))
     :evidence
     '((find "_" "ps14.txt" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "5.5"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (touch "mail/dwarf" "joe.txt")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (tar "_" "mail_dwarf.tar.gz" "mail" "dwarf")
      (tar "_" "mail_dwarf_dwarf.tar.gz" "mail" "dwarf")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "5.5"))
     :evidence
     '((find "_" "*5.5" "_" "_" "**dot_0**")
      (find "_" "5.5" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-free "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((df "/home/vax1" "u")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "linux"))
     :evidence
     '((find "_" "aml" "_" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "code/set" "linux" "mail/dwarf" "aml.pl" "_" "mv(code/set" "linux" "mail/dwarf/2/intro" "aml.config")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "canberra"))
     :evidence
     '((ping "canberra" "_")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "dwarf"))
     :evidence
     '((touch "dwarf" "bob.bob")
      (dir "_" "**dot_0**")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (touch "mail/mickey/dwarf" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (touch "code/gang/linux" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "dll" "_" "_" "**dot_0**")
      (ls "./mail/dwarf" "pgeasy.dll")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "pl" "_" "_" "**dot_0**")
      (mv "mail/linux" "**dot_0**" "bin" "pl")
      (mv "mail/linux" "**dot_0**" "bin/gang" "pl")
      (mv "mail/linux" "**dot_0**" "bin/gang/dwarf/dwarf" "constructor.pl")
      (mv "mail/linux" "**dot_0**" "mail/linux/set" "pl")
      (find "_" "pl" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((find "_" "libtool" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "5.5"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((ls "_" "**dot_0**")
      (du "vax1.cs.rochester.edu:/home/vax1" "u")
      (man "rsh")
      (cd "/home/vax1" "u")
      (df "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((find "_" "c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "**dot_0**" "_" "_" "**dot_0**")
      (find "_" "**dot_0**" "_" "_" "**dot_0**")
      (find "_" "**dot_0**" "_" "_" "**dot_0**")
      (mv "/bin/dwarf" "**dot_0**" "/mail/linux/gang" "5.5.aux")
      (mv "bin/dwarf" "**dot_0**" "mail/linux/gang" "5.5.aux")
      (mv "bin/dwarf" "**dot_0**" "bin/dwarf/dwarf" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "pl"))
     :evidence
     '((find "_" "pl" "_" "_" "**dot_0**")
      (rm "_" "pl")
      (find "_" "pl" "_" "_" "**dot_0**")
      (rm "bin/linux" "convert.pl")
      (rm "bin/linux/dwarf/3" "aml.pl")
      (rm "mail/gang/gang" "accessor.pl")
      (rm "mail/gang/gang/dwarf" "constructor.pl")
      (find "_" "**dot_0**" "_" "_" "**dot_0**")
      (find "_" "pl" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "amsterdam"))
     :evidence
     '((ping "amsterdam" "_")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "gang" "_" "_" "**dot_0**")
      (find "_" "5.5" "_" "_" "**dot_0**")
      (mv "bin/gang" "**dot_0**" "bin/gang/gang" "5.5.dvi")
      (mv "bin/gang" "**dot_0**" "mail/linux" "5.5.ps")
      (mv "bin/gang" "**dot_0**" "mail/linux" "5.5.aux")
      (mv "bin/gang" "**dot_0**" "mail/set/dwarf" "5.5.tex")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "slate.cs.rochester.edu:/var/mail"))
     :evidence
     '((man "df")
      (df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((df "_" "**dot_0**")
      (df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "linux"))
     :evidence
     '((find "_" "aml" "_" "_" "**dot_0**")
      (find "_" "aml" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (find "_" "linux" "_" "_" "**dot_2**")
      (mv "./bin/2" "linux" "./bin/2" "aml.pl")
      (mv "./bin/2" "linux" "./bin/2" "aml.config")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "linux"))
     :evidence
     '((find "_" "ps" "_" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "./bin" "linu" "./bin" "chapin-research.ps")
      (mv "./bin" "linux" "./bin/2" "aslisp1.ps")
      (mv "./bin" "linux" "./code" "5.5.ps")
      (mv "./bin/linux" "chapin-research.ps" "./bin" "linu")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (cd "bin" "dwarf")
      (ls "_" "**dot_1**")
      (touch "_" "bob.bob")
      (ls "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "_" "ckey")
      (cd "_" "mickey")
      (ls "_" "**dot_3**")
      (cd "_" "set")
      (ls "_" "**dot_4**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (mv "mail/2" "linux" "code/dwarf/gang/gang" "capture.txt")
      (mv "mail/2" "linux" "mail" "5.5.aux")
      (ls "mail/2" "linux")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (mv "code" "dwarf" "mail" "a")
      (mv "code" "dwarf" "/mail/gang" "pl")
      (mv "code" "dwarf" "mail/gang" "pl")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "linux"))
     :evidence
     '((ls "_" "eps")
      (ls "_" "**dot_0**")
      (mv "code" "linux" "bin/dwarf/intro" "eps")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "mickey"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "_" "gang")
      (ls "_" "**dot_2**")
      (man "gzip")
      (man "gzip")
      (gzip "_" "help")
      (man "tar")
      (ls "_" "**dot_2**")
      (gzip "_" "mickey")
      (gzip "_" "mickey")
      (ls "_" "**dot_2**")
      (tar "_" "mickey" "_" "mickey")
      (zip "_" "mickey" "_" "mickey")
      (ls "_" "**dot_2**")
      (cd "_" "gang")
      (ls "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (cd "_" "**dotdot_4**")
      (ls "_" "**dot_5**")
      (cd "_" "true")
      (ls "_" "**dot_6**")
      (cd "_" "gang")
      (ls "_" "**dot_7**")
      (cd "_" "**dotdot_7**")
      (cd "_" "**dotdot_8**")
      (ls "_" "**dot_9**")
      (cd "_" "3")
      (ls "_" "**dot_10**")
      (cd "_" "**dotdot_10**")
      (cd "_" "**dotdot_11**")
      (ls "_" "**dot_12**")
      (cd "_" "mail")
      (ls "_" "**dot_13**")
      (cd "_" "**dotdot_13**")
      (cd "_" "bin")
      (ls "_" "**dot_15**")
      (cd "_" "2")
      (ls "_" "**dot_16**")
      (cd "_" "linux")
      (ls "_" "**dot_17**")
      (cd "_" "**dotdot_17**")
      (cd "_" "**dotdot_18**")
      (ls "_" "**dot_19**")
      (cd "_" "set")
      (ls "_" "**dot_20**")
      (cd "_" "dwarf")
      (ls "_" "**dot_21**")
      (cd "_" "dwarf")
      (ls "_" "**dot_22**")
      (cd "_" "**dotdot_22**")
      (cd "_" "intro")
      (ls "_" "**dot_24**")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "_" "gang")
      (ls "_" "**dot_2**")
      (cd "_" "**dotdot_2**")
      (cd "_" "2")
      (ls "_" "**dot_4**")
      (cd "_" "dwarf")
      (ls "_" "**dot_5**")
      (pico "_" "**dot_5**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      (cd "_" "code")
      (cd "_" "info")
      (ls "_" "**dot_2**")
      (cd "_" "intro")
      (zip "_" "dwarf" "_" "dwarf")
      (cd "_" "**dotdot_3**")
      (cd "_" "**dotdot_4**")
      (cd "_" "mail")
      (cd "_" "dwarf")
      (ls "_" "**dot_7**")
      (cd "_" "true")
      (ls "_" "**dot_8**")
      (cd "_" "**dotdot_8**")
      (cd "_" "**dotdot_9**")
      (cd "_" "mail")
      (ls "_" "**dot_11**")
      (zip "_" "dwarf" "_" "dwarf")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "dwarf"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      (cd "_" "code")
      (cd "_" "true")
      (zip "_" "dwarf" "_" "dwarf")
      (cd "_" "**dotdot_2**")
      (ls "_" "**dot_3**")
      (cd "_" "gang")
      (ls "_" "**dot_4**")
      (zip "_" "dwarf" "_" "dwarf")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      (cd "_" "mail")
      (cd "_" "gang")
      (cd "_" "2")
      (cd "_" "linux")
      (ls "_" "**dot_4**")
      (ls "_" "**dot_4**")
      (cat "_" "bob.bob")
      (man "cat")
      (pico "_" "bob.bob")
      (ls "_" "**dot_4**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((copy-files-by-attr-name-ext "ps" "linux"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      (cp "code" "linux" "bin" "gang*.ps")
      (cp "code" "linux" "bin/gang" "ps")
      (cp "code" "linux" "code/3" "ps")
      (cp "code" "linux" "code/gang/set" "ps")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "5.5"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "gang")
      (ls "_" "**dot_2**")
      (ls "_" "**dot_2**")
      (cd "_" "**dotdot_2**")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "cod")
      (ls "_" "**dot_5**")
      (cd "_" "code")
      (ls "_" "**dot_6**")
      (cd "_" "gang")
      (ls "_" "**dot_7**")
      (ls "_" "**dot_7**")
      (ls "_" "**dot_7**")
      (tar "_" "bang1.tar" "_" "dwarf" "_" "tar(" "bang1.tar" "_" "linux")
      (ls "_" "**dot_7**")
      (gzip "_" "bang1.tar")
      (ls "_" "**dot_7**")
      (cd "_" "**dotdot_7**")
      (ls "_" "**dot_8**")
      (cd "_" "**dotdot_8**")
      (ls "_" "**dot_9**")
      (cd "_" "mail")
      (ls "_" "**dot_10**")
      (cd "_" "**dotdot_10**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "tex"))
     :evidence
     '((man "grep")
      (man "tind")
      (man "find")
      (find "_" "tex" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-dir "my_thesis.txt" "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (mkdir "./bin/gang" "my_thesis.txt")
      ))

   (make-exp-case
     :groundtruth '((create-dir "s2" "2"))
     :evidence
     '((find "_" "2" "_" "_" "**dot_0**")
      (mkdir "bin/3/2" "s2")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "dwarf"))
     :evidence
     '((man "find")
      (find "_" "_" "059" "_" "**dot_0**")
      (find "_" "_" "59" "_" "**dot_0**")
      (find "_" "_" "50" "_" "**dot_0**")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (mv "mail/gang" "dwarf" "code" "5.5.aux")
      (mv "mail/gang" "dwarf" "code/mickey/2/true" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "5.5"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "porter"))
     :evidence
     '((ping "porter" "_")
      (jobs "_")
      ))

   (make-exp-case
     :groundtruth '((copy-files-by-attr-size-lt "50" "linux"))
     :evidence
     '((find "_" "_" "50" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "code" "linux" "bin" "5.5.aux")
      (mv "code" "linux" "code/linux/gang" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((create-dir "my_thesis.txt" "2"))
     :evidence
     '((find "_" "2" "_" "_" "**dot_0**")
      (mkdir "code/2" "my_thesis.txt")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Feb21"))
     :evidence
     '((man "find")
      (find "_" "_" "_" "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "linux"))
     :evidence
     '((find "_" "ps" "_" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "bin" "linux" "bin/linux" "ps")
      (mv "bin" "linux" "bin/dwarf" "ps")
      (mv "bin" "linux" "code/gang/true/dwarf" "ps")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "porter"))
     :evidence
     '((ping "porter" "_")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (mv "_" "dwarf" "*/*" "pl")
      (mv "mail" "dwarf" "*/*" "pl")
      (find "_" "pl" "_" "_" "**dot_0**")
      (mv "mail" "dwarf" "code" "pl")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((df "/home/vax1" "u")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "linux"))
     :evidence
     '((find "_" "ps" "_" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "bin/gang/dwarf" "linux" "bin/2/intro" "ps")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      (du "./mail/set" "pgeasy.dll")
      (ls "./mail/set" "pgeasy.dll")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (ls "_" "code" "_" "ls(" "gang")
      (ls "_" "mail" "_" "ls(" "gang")
      (find "_" "5.5" "_" "_" "**dot_0**")
      (mv "code" "gang" "bin" "5.5")
      (mv "code" "gang" "mail/*" "5.5")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "_" "2")
      (ls "_" "**dot_2**")
      (cd "_" "gang")
      (ls "_" "**dot_3**")
      (cd "../.." "3")
      (ls "_" "**dot_4**")
      (cd "**dotdot_4**" "**dotdot_4**")
      (ls "_" "**dot_5**")
      (cd "_" "mail")
      (ls "_" "**dot_6**")
      (cd "_" "dwarf")
      (ls "_" "**dot_7**")
      (cd "_" "gang")
      (ls "_" "**dot_8**")
      (cd "_" "**dotdot_8**")
      (cd "_" "true")
      (ls "_" "**dot_10**")
      (cd "_" "**dotdot_10**")
      (pwd "_")
      (cd "_" "**dotdot_11**")
      (cd "_" "**dotdot_12**")
      (ls "_" "**dot_13**")
      (ls "_" "**dot_13**")
      (ls "_" "**dot_13**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "./bin" "gang")
      (tar "_" "gang.tgz" "_" "**dot_1**")
      (tar "_" "gang.tgz" "_" "**dot_1**")
      (ls "_" "**dot_1**")
      (ls "_" "**dot_1**")
      (pwd "_")
      (cd "**dotdot_1**" "**dotdot_1**")
      (ls "_" "**dot_2**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "ps14.txt"))
     :evidence
     '((ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (mv "**dot_0**" "linux" "./code" "aml.pl")
      (mv "_" "linux" "./code/3" "aml.config")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "pl"))
     :evidence
     '((rm "_" "pl")
      (ls "_" "**dot_0**")
      (cd "_" "bin")
      (rm "_" "pl")
      (ls "_" "**dot_1**")
      (cd "_" "3")
      (rm "_" "pl")
      (cd "**dotdot_2**" "intro")
      (rm "_" "pl")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (rm "./3/linux" "pl")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Jan21"))
     :evidence
     '((ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-dir "egg_salad.exe" "2"))
     :evidence
     '((ls "_" "**dot_0**")
      (mkdir "./bin/gang/2" "egg_salad.exe")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (mv "./mail/set" "dwarf" "./mail/set/true" "ps")
      (mv "./mail/set" "dwarf" "./mail/mickey" "ps")
      (mv "./mail/set" "dwarf" "./mail/3" "ps")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "2"))
     :evidence
     '((ls "_" "**dot_0**")
      (tar "_" "2.tgz" "./bin/gang" "2")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "mail" "linux")
      (touch "_" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((create-dir "my_thesis.txt" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (mkdir "./bin/2/gang/linux" "my_thesis.txt")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (mv "./bin" "linux" "./bin" "eps")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "ps"))
     :evidence
     '((ls "_" "**dot_0**")
      (rm "./mail/linux" "ps")
      (rm "./code/intro" "ps")
      (rm "./code/2" "ps")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (mv "./code/mickey" "dwarf" "/mail" "cture.txt")
      (mv "./code/mickey" "dwarf" "./mail" "capture.txt")
      (mv "./code/mickey" "dwarf" "./bin/2" "5.5.aux")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (grep "dwaf" "_" "tmp")
      (grep "dwarf" "_" "tmp")
      (touch "./code/dwarf" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "linux"))
     :evidence
     '((find "_" "_" "38400" "_" "**dot_0**")
      (cat "_" "find.tmp")
      (ls "**dot_0**" "mail")
      (find "_" "_" "38400" "_" "**dot_0**")
      (find "_" "_" "38400" "_" "**dot_0**")
      (find "_" "_" "38400" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (find "_" "_" "75" "_" "**dot_0**")
      (mv "./code" "linux" "./bin/intro/2/gang" "capture.txt" "_" "mv(./code" "linux" "./code/true/gang/3" "5.5.aux")
      ))

   (make-exp-case
     :groundtruth '((create-dir "my_thesis.txt" "2"))
     :evidence
     '((find "_" "2" "_" "_" "**dot_0**")
      (mkdir "./bin/2" "my_thesis.txt")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (tar "_" "dwarf.tar" "./bin" "dwarf")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "linux"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      (find "_" "5.5" "_" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "./code/true/gang" "linux" "./bin" "5.5.tex")
      (mv "./code/true/gang" "linux" "./bin/dwarf/gang" "5.5.aux")
      (mv "./code/true/gang" "linux" "./code/gang" "5.5.dvi")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "amsterdam"))
     :evidence
     '((ping "amsterdam" "_")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((find "_" "libtool" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((ls "_" "**dot_0**")
      (grep "lsout" "_" "pgeasy.dll")
      (grep "pgeasy.dll" "_" "lsout")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-size-gt "50000"))
     :evidence
     '((find "_" "_" "50000" "_" "**dot_0**")
      (rm "./code" "aslisp1.ps")
      (rm "./mail/2/true" "chapin-research.ps")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "pl"))
     :evidence
     '((find "_" "pl" "_" "_" "**dot_0**")
      (rm "./bin" "accessor.pl")
      (rm "./bin/set/dwarf/true" "convert.pl")
      (rm "./mail" "constructor.pl")
      (rm "./mail" "aml.pl")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((man "find")
      (find "_" "rl.exe" "_" "_" "**dot_0**")
      (find "_" "rl.exe" "_" "_" "**dot_0**")
      (find "_" "rl.exe" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "dwarf"))
     :evidence
     '((find "_" "rl.exe" "_" "_" "**dot_0**")
      (find "_" "_" "75" "_" "**dot_0**")
      (cat "_" "findout")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (cat "_" "findout")
      (mv "./code" "dwarf" "./bin/intro" "5.5.aux" "_" "mv(./code" "dwarf" "./bin/intro/2" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (find "_" "_" "38400" "_" "**dot_0**")
      (find "_" "_" "75" "_" "**dot_0**")
      (mv "./bin" "dwarf" "./mail" "capture.txt" "_" "mv(./bin" "dwarf" "./bin/dwarf/2" "5.5.aux")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (find "_" "pl" "_" "_" "**dot_0**")
      (mv "./code" "linux" "./bin/gang/set" "convert.pl" "_" "mv(./code" "linux" "./code" "accessor.pl" "_" "mv(./code" "linux" "./code" "constructor.pl" "_" "mv(./code" "linux" "./code/gang/dwarf" "aml.pl")
      ))

   (make-exp-case
     :groundtruth '((create-dir "egg_salad.exe" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (mkdir "./bin/gang/linux" "egg_salad.exe")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (find "_" "eps" "_" "_" "**dot_0**")
      (mv "./bin" "dwarf" "./code" "agent.eps")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "README" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (find "_" "5.5" "_" "_" "**dot_0**")
      (mv "./bin" "gang" "./bin/gang" "5.5.ps" "_" "mv(./bin" "gang" "./code" "5.5.tex" "_" "mv(./bin" "gang" "./code/dwarf/intro" "5.5.aux" "_" "mv(./bin" "gang" "./code/dwarf/2/mickey" "5.5.dvi")
      (find "_" "5.5" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (find "_" "aml" "_" "_" "**dot_0**")
      (mv "./bin" "gang" "./bin/set" "aml.pl" "_" "mv(./bin" "gang" "./mail/gang/2/intro" "aml.config")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (touch "./mail/2/linux" "joe.txt")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (mkdir "./bin/dwarf/dwarf/linux" "joe.txt")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (touch "./bin/mickey/dwarf" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (touch "./mail/gang/linux" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "linux"))
     :evidence
     '((find "_" "eps" "_" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "./bin/gang" "linux" "./code/set/2/mickey" "agent.eps")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (touch "./bin/dwarf" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Feb21"))
     :evidence
     '((man "find")
      (find "_" "_" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (grep "Feb 21" "_" "lsout")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Jan21"))
     :evidence
     '((ls "_" "**dot_0**")
      (grep "Jan 21" "_" "lsout")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((ls "_" "**dot_0**")
      (grep "rl.exe" "_" "lsout")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "amsterdam"))
     :evidence
     '((ping "amsterdam" "_")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "linux"))
     :evidence
     '((find "_" "pl" "_" "_" "**dot_0**")
      (find "_" "pl" "_" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "./mail/dwarf" "linux" "./bin/gang/mickey" "convert.pl" "_" "mv(./mail/dwarf" "linux" "./code/dwarf/set" "aml.pl" "_" "mv(./mail/dwarf" "linux" "./mail" "accessor.pl" "_" "mv(./mail/dwarf" "linux" "./mail/dwarf" "constructor.pl")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "amsterdam"))
     :evidence
     '((ping "amsterdam" "_")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "pl"))
     :evidence
     '((find "_" "pl" "_" "_" "**dot_0**")
      (rm "./bin/2" "constructor.pl" "_" "rm(./bin/linux/dwarf" "aml.pl" "_" "rm(./mail/gang" "convert.pl" "_" "rm(./mail/intro" "accessor.pl")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-size-gt "50000"))
     :evidence
     '((find "_" "_" "50000" "_" "**dot_0**")
      (rm "./bin/linux" "chapin-research.ps" "_" "rm(./mail/2" "aslisp1.ps")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "nye"))
     :evidence
     '((ping "nye" "_")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (pwd "_")
      (find "_" "5.5" "_" "_" "**dot_0**")
      (find "_" "gang" "_" "_" "**dot_0**")
      (mv "./mail/set" "gang" "./bin/mickey" "5.5.tex")
      (mv "./mail/set" "gang" "./bin/mickey" "5.5.ps")
      (mv "./mail/set" "gang" "./mail/set/dwarf" "5.5.aux")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "tex"))
     :evidence
     '((find "_" "tex" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "README" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (cd "./mail/2" "linux")
      (touch "_" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (cd "./mail/gang" "dwarf")
      (touch "_" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "dwarf"))
     :evidence
     '((find "_" "pl" "_" "_" "**dot_0**")
      (find "_" "_" "_" "_" "dwarf")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (mv "./mail/2" "dwarf" "./code" "aml.pl")
      (mv "./mail/2" "dwarf" "./code/3" "constructor.pl")
      (mv "./mail/2" "dwarf" "./mail" "convert.pl")
      (mv "./mail/2" "dwarf" "./mail/mickey" "accessor.pl")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "gang"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      (find "_" "gang" "_" "_" "**dot_0**")
      (mv "./mail/3" "gang" "./code/gang" "5.5.tex")
      (mv "./mail/3" "gang" "./mail" "5.5.dvi")
      (mv "./mail/3" "gang" "./mail/3" "5.5.ps")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "hoover.csug.rochester.edu:/u"))
     :evidence
     '((df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "dwarf"))
     :evidence
     '((man "find")
      (find "_" "_" "50" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (find "_" "_" "50" "_" "**dot_0**")
      (ls "./code/true" "5.5.aux" "_" "ls(./mail/2/gang" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (touch "mail/dwarf" "joe.txt")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (touch "code/dwarf" "joe.txt")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "linux"))
     :evidence
     '((find "_" "ps" "_" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "./bin/3/2" "linux" "./bin" "aslisp1.ps" "_" "mv(./bin/3/2" "linux" "./bin/dwarf" "chapin-research.ps" "_" "mv(./bin/3/2" "linux" "./mail/set" "5.5.ps")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "mickey"))
     :evidence
     '((find "_" "mickey" "_" "_" "**dot_0**")
      (cd "bin" "dwarf")
      (ls "_" "mickey")
      (ls "_" "mickey")
      (tar "_" "mickey.tar.gz" "_" "mickey")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "mickey"))
     :evidence
     '((find "_" "mickey" "_" "_" "**dot_0**")
      (ls "bin/gang" "mickey")
      (tar "_" "mickey.tar.gz" "bin/gang" "mickey")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (ls "code" "gang")
      (ls "mail" "gang")
      (ls "mail/intro" "gang")
      (cd "mail" "gang")
      (tar "_" "3.tar.gz" "_" "3")
      (tar "_" "dwarf.tar.gz" "_" "dwarf")
      (ls "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      (ls "code/dwarf" "pgeasy.dll")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((find "_" "libtool" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "linux"))
     :evidence
     '((find "_" "aml" "_" "_" "**dot_0**")
      (find "_" "aml" "_" "_" "**dot_0**")
      (mv "_" "linux" "./code" "aml.config" "_" "mv(" "linux" "./code/gang/true/linux" "aml.pl")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "./code/gang/true" "linux" "./code" "aml.config" "_" "mv(./code/gang/true" "linux" "./code/gang/true/linux" "aml.pl")
      (mv "./code/gang/true" "linux" "./code" "aml.config")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "dwarf"))
     :evidence
     '((find "_" "_" "75" "_" "**dot_0**")
      (ls "./code/gang/2/intro" "5.5.aux" "_" "ls(./code/linux/true/3" "capture.txt")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (file "code" "dwarf")
      (mv "code" "dwarf" "./code/gang/2/intro" "5.5.aux" "_" "mv(code" "dwarf" "./code/linux/true/3" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((find "_" "rl.exe" "_" "_" "**dot_0**")
      (ls "_" "!")
      (ls "bin/2" "rl.exe")
      (du "bin/2" "rl.exe")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "2"))
     :evidence
     '((find "_" "2" "_" "_" "**dot_0**")
      (cd "_" "mail")
      (ls "_" "2")
      (tar "_" "2.tar.gz" "_" "2")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((find "_" "libtool" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (find "_" "_" "75" "_" "**dot_0**")
      (mv "./bin/dwarf" "linux" "./bin/dwarf" "5.5.aux")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((find "_" "c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Feb21"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "dwarf"))
     :evidence
     '((mv "_" "dwarf" "_" "eps")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((tar "_" "dwarf.tar" "_" "dwarf")
      ))

   (make-exp-case
     :groundtruth '((create-dir "my_thesis.txt" "2"))
     :evidence
     '((cd "_" "2")
      (dir "_" "**dot_1**")
      (cd "_" "bin")
      (dir "_" "**dot_2**")
      (dir "_" "**dot_2**")
      (cd "_" "gang")
      (dir "_" "**dot_3**")
      (dir "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (cd "_" "**dotdot_4**")
      (dir "_" "**dot_5**")
      (cd "_" "code")
      (dir "_" "**dot_6**")
      (cd "_" "2")
      (mkdir "_" "my_thesis.txt")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((dir "_" "**dot_0**")
      (cd "_" "bin")
      (dir "_" "-")
      (dir "_" "**dot_1**")
      (dir "_" "**dot_1**")
      (cd "_" "set")
      (dir "_" "**dot_2**")
      (cd "_" "gang")
      (dir "_" "**dot_3**")
      (man "gzip")
      (dir "_" "**dot_3**")
      (gzip "_" "**dot_3**")
      (dir "_" "**dot_3**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((find "_" "_" "_" "_" "rl.exe")
      (man "find")
      (find "_" "_" "_" "_" "**dot_0**")
      (cd "_" "code")
      (cd "_" "true")
      (dir "_" "**dot_2**")
      (dir "_" "**dot_2**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "README" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "gang"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      (find "_" "gang" "_" "_" "**dot_0**")
      (mv "./bin/gang" "gang" "./code" "5.5.ps")
      (mv "./bin/gang" "gang" "./code" "5.5.dvi")
      (mv "./bin/gang" "gang" "./mail/dwarf/set" "5.5.tex")
      (find "_" "5.5" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-size-gt "40000"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "*" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      (rm "./bin/dwarf/chapin-research.ps./code/linux" "aslisp1.ps" "_" "rm(./mail/2" "cycle.tiff")
      (rm "./bin/dwarf" "chapin-research.ps" "_" "rm(./code/linux" "aslisp1.ps")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (touch "./mail/linux" "bob.bob")
      (ls "./mail/linux" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-free "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-free "slate.cs.rochester.edu:/var/mail"))
     :evidence
     '((df "/var" "mail")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((find "_" "libtool" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-dir "egg_salad.exe" "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (mkdir "./code/gang" "egg_salad.exe")
      (ls "./code/gang" "egg_salad.exe")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((find "_" "rl.exe" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (tar "_" "gang.tar.gz" "./code/gang" "**dot_0**" "_" "tar(" "gang.tar.gz" "./code/gang/gang" "**dot_0**" "_" "tar(" "gang.tar.gz" "./mail/true/gang" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "5.5"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "2"))
     :evidence
     '((find "_" "2" "_" "_" "**dot_0**")
      (ls "./code" "2")
      (tar "_" "mickey.tar.gz" "./code/2" "mickey")
      (ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "_" "code")
      (ls "_" "mail")
      (mv "mail" "linux" "mail" "capture.txt")
      (cd "_" "code")
      (ls "_" "dwarf")
      (ls "dwarf" "gang")
      (ls "_" "**dot_1**")
      (ls "_" "mickey")
      (ls "mickey" "3")
      (cd "**dotdot_1**" "mail")
      (ls "_" "**dot_2**")
      (ls "_" "dwarf")
      (ls "dwarf" "gang")
      (ls "_" "gang")
      (ls "gang" "2")
      (ls "gang" "intro")
      (mv "_" "linux" "gang/intro" "5.5.aux")
      (ls "gang/2" "true")
      (ls "_" "**dot_2**")
      (ls "_" "**dot_2**")
      (ls "_" "set")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "_" "3")
      (ls "_" "**dot_2**")
      (cd "**dotdot_2**" "true")
      (ls "_" "**dot_3**")
      (cd "_" "dwarf")
      (ls "_" "**dot_4**")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "_" "code")
      (ls "_" "mail")
      (ls "bin" "3")
      (ls "bin/3" "linux")
      (ls "bin" "gang")
      (cd "bin/gang" "dwarf")
      (echo "i" "_" "echo(am" "_" "echo(bob")
      (echo "i" "_" "echo(am" "_" "echo(bob")
      (ls "_" "**dot_1**")
      (more "_" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "amsterdam"))
     :evidence
     '((ping "amsterdam" "_")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "mickey")
      (ls "_" "**dot_2**")
      (ls "_" "dwarf")
      (ls "dwarf" "gang")
      (cd "dwarf" "gang")
      (ls "_" "**dot_3**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Feb21"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "code")
      (ls "_" "code")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (ls "_" "**dot_2**")
      (cd "_" "bin")
      (ls "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "code")
      (ls "_" "**dot_5**")
      (cd "_" "**dotdot_5**")
      (ls "_" "**dot_6**")
      (cd "_" "mail")
      (ls "_" "**dot_7**")
      (cd "_" "**dotdot_7**")
      (ls "_" "**dot_8**")
      (ls "_" "**dot_8**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "mickey"))
     :evidence
     '((compress "_" "mickey")
      (ls "_" "**dot_0**")
      (cd "_" "bin")
      (cd "_" "3")
      (ls "_" "**dot_2**")
      (compress "_" "mickey")
      (ls "_" "**dot_2**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Jan21"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "bin/intro" "2")
      (ls "_" "**dot_1**")
      (mv "../../../bin/dwarf/gang" "linux" "_" "aml.pl")
      (cd "../.." "**dotdot_1**")
      (ls "_" "**dot_2**")
      (cd "_" "code")
      (ls "_" "**dot_3**")
      (mv "../bin/dwarf/gang" "linus" "_" "aml.config")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "code/gang" "dwarf")
      (pico "_" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "a.c" "_" "_" "**dot_0**")
      (find "_" "a.c" "_" "_" "**dot_0**")
      (cd "bin" "set")
      (ls "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "mail")
      (ls "_" "code")
      (ls "_" "bin")
      (ls "_" "bin")
      (ls "bin" "linux")
      (ls "code" "**dot_0**")
      (ls "code/*" "**dot_0**")
      (mv "bin" "linux" "code" "cture.txt")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (ls "../bin" "linux")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (ls "_" "code")
      (ls "_" "mail")
      (ls "code/*" "**dot_2**")
      (mv "bin/linux" "**dot_2**" "code/gang" "capture.txt")
      (mv "bin" "linux" "code/gang/intro" "5.5.aux")
      (ls "code/gang" "2")
      (ls "_" "**dot_2**")
      (ls "mail" "**dot_2**")
      (ls "mail" "**dot_2**")
      (ls "mail/*" "**dot_2**")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "linux"))
     :evidence
     '((touch "_" "joe.txt")
      (ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((ls "_" "**dot_0**")
      (fgrep "libtool" "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (cd "_" "code")
      (ls "_" "**dot_3**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "5.5"))
     :evidence
     '((fgrep "5.5" "_" "**dot_0**")
      (cd "code" "dwarf")
      (ls "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (cd "_" "code")
      (ls "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "mail")
      (ls "_" "**dot_5**")
      (cp "~" "dwarf" "_" "aslisp1.ps")
      (ls "_" "**dot_5**")
      (cd "_" "**dotdot_5**")
      (ls "_" "**dot_6**")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (fgrep "linux" "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "1")
      (cd "_" "2")
      (ls "_" "**dot_3**")
      (cd "_" "linux")
      (touch "_" "bob.bob")
      (ls "_" "**dot_4**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((fgrep "README" "_" "**dot_0**")
      (cd "bin" "gang")
      (ls "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((create-dir "s2" "linux"))
     :evidence
     '((fgrep "linux" "_" "**dot_0**")
      (grep "linux" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "gang")
      (ls "_" "**dot_2**")
      (cd "_" "intro")
      (ls "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (cd "_" "**dotdot_4**")
      (ls "_" "**dot_5**")
      (cd "_" "**dot_5**")
      (cd "_" "tru")
      (ls "_" "**dot_7**")
      (cd "_" "true")
      (ls "_" "**dot_8**")
      (cd "_" "dwarf")
      (ls "_" "**dot_9**")
      (cd "_" "**dotdot_9**")
      (cd "_" "**dotdot_10**")
      (ls "_" "**dot_11**")
      (cd "_" "**dotdot_11**")
      (ls "_" "**dot_12**")
      (cd "_" "code")
      (ls "_" "**dot_13**")
      (cd "_" "linux")
      (ls "_" "**dot_14**")
      (mkdir "_" "s2")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "dorito.csug.rochester.edu:/var/mail"))
     :evidence
     '((ls "_" "**dot_0**")
      (ruptime "_")
      (cd "_" "dorito.csug.rochester.edu")
      (ls "_" "**dot_1**")
      (cd "_" "mail")
      (ls "_" "**dot_2**")
      (mount "_")
      (ls "_" "**dot_2**")
      (cd "_" "**dotdot_2**")
      (ls "_" "**dot_3**")
      (ls "_" "**dot_3**")
      (ls "_" "**dot_3**")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "porter"))
     :evidence
     '((ping "porter" "_")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "README" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (tar "bin" "dwarf.tar" "bin" "dward")
      (tar "bin" "dwarf.tar" "bin" "dwarf")
      (ls "_" "**dot_0**")
      (ls "mail/true" "dwarf")
      (tar "mail/true" "dwarf.tar" "mail/true" "dwarf")
      (gzip "mail/true" "dwarf.tar")
      (gzip "bin" "dwarf.tar")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "ps14.txt"))
     :evidence
     '((du "_" "ps14.txt")
      (find "_" "_" "_" "_" "ps14.txt")
      (find "_" "ps14.txt" "_" "_" "**dot_0**")
      (du "bin" "ps14.txt")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "gang"))
     :evidence
     '((find "_" "aml" "_" "_" "**dot_0**")
      (mv "_" "gang" "mail/gang" "aml.ps" "_" "mv(" "gang" "mail/gang/set" "aml")
      (ls "_" "**dot_0**")
      (find "_" "gang" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "gang"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "ps"))
     :evidence
     '((find "_" "ps" "_" "_" "**dot_0**")
      (rm "bin/3/2" "ps" "_" "rm(bin/gang/dwarf" "ps" "_" "rm(bin/gang/dwarf/gang" "ps")
      (find "_" "ps" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "tex"))
     :evidence
     '((find "_" "tex" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-free "dorito.csug.rochester.edu:/var/mail"))
     :evidence
     '((df "dorito.csug.rochester.edu:/var" "mail")
      (df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((find "_" "b.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((find "_" "rl.exe" "_" "_" "**dot_0**")
      (ls "bin/2/intro" "rl.exe")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-free "hoover.csug.rochester.edu:/u"))
     :evidence
     '((df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "porter"))
     :evidence
     '((ping "porter" "_")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "pl"))
     :evidence
     '((find "_" "pl" "_" "_" "**dot_0**")
      (rm "bin/dwarf/set" "pl" "_" "rm(bin/gang" "pl" "_" "rm(code/3" "pl" "_" "rm(code/3/true" "pl")
      (find "_" "pl" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((ls "_" "c")
      (ls "_" "**dot_0**")
      (ls "*" "c")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-free "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((du "vax1.cs.rochester.edu:/home/vax1" "u")
      (df "vax1.cs.rochester.edu:/home/vax1" "u")
      (du "/home/vax1" "u")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((du "/home/vax1" "u")
      (df "/home/vax1" "u")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((ls "_" "code")
      (ls "*" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "linux"))
     :evidence
     '((mv "_" "linux" "_" "ps")
      (ls "*" "**dot_0**")
      (mv "bin" "linux" "bin/mail" "ps" "_" "mv(bin" "linux" "mail/mickey" "ps")
      (ls "_" "**dot_0**")
      (mv "bin" "linux" "mail" "ps")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "ps14.txt"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "*" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((ls "_" "**dot_0**" "_" "ls(*" "**dot_0**")
      (ls "code/gang" "2")
      (cd "code" "gang")
      (ls "_" "dwarf")
      (compress "_" "dwarf")
      (ls "_" "**dot_1**")
      (gzip "_" "dwarf")
      (tar "_" "**dot_1**" "_" "dwarf")
      (gzip "_" "dwarf.tar")
      (ls "_" "**dot_1**")
      (tar "_" "**dot_1**" "_" "dwarf.tar" "_" "tar(" "**dot_1**" "_" "dwarf")
      (ls "_" "**dot_1**")
      (tar "_" "dwarf.tar" "_" "dwarf")
      (ls "_" "**dot_1**")
      (gzip "_" "dwarf.tar")
      (pwd "_")
      (cd "**dotdot_1**" "2")
      (cd "_" "2")
      (ls "_" "**dot_3**")
      (tar "_" "dwarf.tar" "_" "dwarf")
      (gzip "_" "dwarf.tar")
      (cd "**dotdot_3**" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (ls "_" "3" "_" "ls(3" "**dot_4**")
      (cd "_" "**dotdot_4**")
      (ls "_" "**dot_5**")
      (ls "_" "**dot_5**" "_" "ls(*" "s")
      (ls "*" "**dot_5**")
      (ls "mail/gang" "mickey")
      (ls "bin/linux" "intro")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "_" "_" "_" "dwarf")
      (find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "dwarf")
      (find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "dwarf")
      (egrep "dwarf" "_" "foo")
      (less "_" "bar")
      (egrep "dwarf" "_" "bar")
      (less "_" "baz")
      (tar "_" "dwarf.tar" "_" "baz")
      ))

   (make-exp-case
     :groundtruth '((create-dir "s2" "2"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "2")
      (find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "2")
      (egrep "2" "_" "foo")
      (less "_" "bar")
      (cd "code" "2")
      (mkdir "_" "s2")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "linux"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "5.5")
      (less "_" "foo")
      (find "_" "_" "_" "_" "**dot_0**")
      (man "find")
      (find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "5.5")
      (find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "5")
      (find "_" "5.5" "_" "_" "**dot_0**")
      (find "_" "5.5" "_" "_" "**dot_0**")
      (man "mv")
      (find "_" "linux" "_" "_" "**dot_0**")
      (less "_" "foo")
      (mv "./bin/dwarf" "linux" "./bin/dwarf" "5.5.dvi")
      (mv "bin/dwarf" "linux" "./mail" "5.5.ps")
      (mv "/bin/dwarf" "linux" "mail/2/intro" "5.5.aux")
      (mv "bin/dwarf" "linux" "mail/2/intro" "5.5.aux")
      (mv "bin/dwarf" "linux" "mail/gang" "5.5.tex")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      (cd "./code/mickey" "pgeasy.dll")
      (cd "./code" "micky")
      (cd "./code" "mickey")
      (ls "_" "**dot_3**")
      (man "ls")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (cd "./mail" "linux")
      (ls "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "ps14.txt"))
     :evidence
     '((find "_" "ps14.txt" "_" "_" "**dot_0**")
      (cd "./mail" "2")
      (ls "_" "**dot_1**")
      (ls "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((create-dir "my_thesis.txt" "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (mkdir "./bin/gang" "my_thesis.txt")
      (ls "./bin" "gang")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "dwarf"))
     :evidence
     '((cd "_" "dwarf")
      (ls "_" "**dot_1**")
      (find "_" "dwarf" "_" "_" "**dot_1**")
      (cd "mail" "dwarf")
      (ls "_" "**dot_2**")
      (ls "_" "2")
      (ls "_" "intro" "_" "ls(" "RunAccel")
      (ls "_" "dwarf")
      (gzip "_" "2" "_" "gzip(" "dwarf" "_" "gzip(" "intro")
      (tar "_" "2.tar" "_" "2")
      (compress "_" "2.tar")
      (tar "_" "dwarf.tar" "_" "dwarf")
      (compress "_" "dwarf.tar")
      (ls "_" "**dot_2**")
      (tar "_" "intro.tar" "_" "intro")
      (compress "_" "intro.tar")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((ls "_" "rl.exe")
      (find "_" "rl.exe" "_" "_" "**dot_0**")
      (ls "mail/2/dwarf" "rl.exe")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "dwarf"))
     :evidence
     '((find "_" "ps" "_" "_" "**dot_0**")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (mv "mail" "dwarf" "mail/dwarf/linux" "chapin-research.ps")
      (mv "mail" "dwarf" "mail/dwarf/set" "aslisp1.ps")
      (mv "mail" "dwarf" "mail/dwarf/set" "5.5.ps")
      (find "_" "ps" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((find "_" "_" "_" "_" "linux")
      (find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "linux")
      (find "_" "linux" "_" "_" "**dot_0**")
      (echo "text file")
      (less "code/linux" "bob.bob")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "linux"))
     :evidence
     '((find "_" "aml" "_" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (mv "bin" "linux" "bin" "aml.config")
      (mv "bin" "linux" "bin/2" "aml.pl")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Jan21"))
     :evidence
     '((find "_" "_" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "bin" "3")
      (ls "bin/3" "gang")
      (ls "bin" "gang")
      (ls "gin/gang" "intro")
      (ls "bin/gang" "intro")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "ps14.txt"))
     :evidence
     '((find "_" "ps14.txt" "_" "_" "**dot_0**")
      (ls "bin" "ps14.txt")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (ls "mail" "linux")
      (cp "mail/linux" "joe.txt" "mail/linux" "zz.txt")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((find "_" "rl.exe" "_" "_" "**dot_0**")
      (ls "code/gang/2" "rl.exe")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "slate.cs.rochester.edu:/var/mail"))
     :evidence
     '((df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (compress "bin" "gang")
      (ls "code" "gang")
      (compress "code/gange" "mickey")
      (compress "code/gang" "mickey")
      (ls "bin" "gang")
      (compress "bin/gang" "2")
      (compress "bin/gang" "3")
      (compress "bin/gang" "true")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "dwarf"))
     :evidence
     '((man "find")
      (find "_" "_" "50" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((copy-files-by-attr-name-ext "pl" "intro"))
     :evidence
     '((find "_" "pl" "_" "_" "**dot_0**")
      (find "_" "intro" "_" "_" "**dot_0**")
      (cd "_" "code")
      (cp "../mail/dwarf" "intro" "_" "convert.pl")
      (cp "../mail/dwarf" "intro" "gang" "accessor.pl")
      (cp "../mail/dwarf" "intro" "linux" "aml.pl")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "tex"))
     :evidence
     '((find "_" "tex" "_" "_" "**dot_0**")
      (pwd "_")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "ps"))
     :evidence
     '((find "_" "ps" "_" "_" "**dot_0**")
      (rm "bin/2/gang" "5.5.ps")
      (rm "code/dwarf/mickey" "aslisp1.ps")
      (rm "mail/gang" "chapin-research.ps")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((ls "_" "**dot_0**")
      (grep "a.c" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (pwd "_")
      (grep "a.c" "_" "**dot_0**")
      (find "_" "_" "_" "_" "a.c")
      (find "_" "_" "_" "_" "a.c" "_" "find(" "_" "_" "_" "**dot_0**")
      (cd "/mail/dwarf" "3")
      (cd "mail/dwarf" "3")
      (ls "_" "**dot_2**")
      (vi "_" "a.c")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "_" "_" "_" "README")
      (find "_" "_" "_" "_" "README" "_" "find(" "_" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "**dotdot_1**" "bin")
      (ls "_" "**dot_2**")
      (cd "**dotdot_2**" "mail")
      (ls "_" "**dot_3**")
      (tar "_" "gang.tar.gz" "_" "gang")
      (tar "_" "gang.tar.gz" "_" "gang")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "bin")
      (ls "_" "**dot_5**")
      (cd "_" "dwarf")
      (ls "_" "**dot_6**")
      (cd "_" "mickey")
      (ls "_" "**dot_7**")
      (cd "_" "**dotdot_7**")
      (ls "_" "**dot_8**")
      (cd "_" "**dot_8**")
      (ls "_" "**dot_9**")
      (cd "_" "**dotdot_9**")
      (ls "_" "**dot_10**")
      (cd "_" "intro")
      (ls "_" "**dot_11**")
      (tar "_" "gang.tar.gz" "_" "gang")
      (cd "_" "linux")
      (ls "_" "**dot_12**")
      (cd "_" "**dotdot_12**")
      (ls "_" "**dot_13**")
      (cd "_" "**dotdot_13**")
      (ls "_" "**dot_14**")
      (cd "_" "intro")
      (ls "_" "**dot_15**")
      (cd "_" "**dotdot_15**")
      (ls "_" "**dot_16**")
      (cd "_" "dwarf")
      (ls "_" "**dot_17**")
      (cd "_" "mickey")
      (ls "_" "**dot_18**")
      (cd "_" "**dotdot_18**")
      (ls "_" "**dot_19**")
      (cd "_" "**dotdot_19**")
      (ls "_" "**dot_20**")
      (cd "_" "set")
      (ls "_" "**dot_21**")
      (cd "**dotdot_21**" "true")
      (ls "_" "**dot_22**")
      (cd "_" "**dotdot_22**")
      (ls "_" "**dot_23**")
      (cd "_" "**dotdot_23**")
      (ls "_" "**dot_24**")
      (cd "_" "code")
      (ls "_" "**dot_25**")
      (cd "**dotdot_25**" "mail")
      (ls "_" "**dot_26**")
      (cd "_" "2")
      (ls "_" "**dot_27**")
      (cd "_" "dwarf")
      (ls "_" "**dot_28**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "code")
      (mv "code" "linux" "_" "pl" "_" "mv(code" "linux" "*" "pl" "_" "mv(code" "linux" "*/*" "pl" "_" "mv(code" "linux" "*/*/*" "pl" "_" "mv(code" "linux" "*/*/*/*" "pl")
      (cd "code" "linux")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (man "find")
      (find "_" "_" "_" "_" "pl")
      (find "_" "_" "_" "_" "**dot_2**")
      (clear "_")
      (pwd "_")
      (cd "_" "**dotdot_2**")
      (find "_" "_" "_" "_" "**dot_3**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "miey")
      (ls "_" "**dot_2**")
      (cd "_" "mickey")
      (ls "_" "**dot_3**")
      (cd "_" "2")
      (ls "_" "**dot_4**")
      (ls "_" "pge-l" "_" "ls(" "pgeasy.dll")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Jan21"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "2")
      (ls "_" "**dot_2**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "_" "_" "_" "a.c")
      (ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (find "_" "_" "_" "_" "c")
      (find "_" "_" "_" "_" "**dot_2**")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "pl"))
     :evidence
     '((rm "_" "pl")
      (find "_" "_" "_" "_" "**dot_0**")
      (cd "_" "bin")
      (rm "_" "pl")
      (find "_" "_" "_" "_" "**dot_1**")
      (cd "_" "dwarf")
      (rm "_" "pl")
      (cd "_" "**dotdot_2**")
      (ls "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (find "_" "_" "_" "_" "**dot_4**")
      (cd "_" "mail")
      (rm "_" "pl")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "_" "_" "_" "b.c")
      (find "_" "_" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((copy-files-by-attr-name-ext "ps" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      (mkdir "_" "linux")
      (ls "_" "**dot_0**")
      (cd "bin" "dwarf")
      (cp "../.." "linux" "_" "ps")
      (cd "**dotdot_1**" "**dotdot_1**")
      (cd "_" "mail")
      (cp "**dotdot_3**" "linux" "_" "ps")
      (cd "_" "**dotdot_3**")
      (cd "_" "linux")
      (ls "_" "**dot_5**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((du "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      (cd "code" "true")
      (du "_" "**dot_1**")
      (ls "_" "**dot_1**")
      (ls "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "amsterdam"))
     :evidence
     '((ping "amsterdam" "_")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "linux")
      (mkdir "_" "linux")
      (touch "_" "bob.bob")
      (ls "_" "**dot_1**")
      (rm "_" "bob.bob")
      (cd "_" "linux")
      (touch "_" "bob.bob")
      (ls "_" "**dot_2**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((find "_" "_" "_" "_" "libtool")
      (find "_" "_" "_" "_" "*libtool*")
      (find "_" "_" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "2")
      (ls "_" "**dot_2**")
      (cd "_" "**dotdot_2**")
      (cd "_" "**dotdot_3**")
      (pwd "_")
      (ls "_" "aml")
      (ls "_" "**dot_4**")
      (mv "code/linux" "a.config" "bin/gang" "aml.config")
      (mv "./code/linux" "aml.pl" "./bin/gang" "aml.pl")
      (mv "code/linux" "aml.config" "bin/2" "aml.config")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (man "tar")
      (info "tar")
      (tar "_" "v" "_" "minidwarf" "_" "tar(" "v" "_" "dwarf")
      (tar "_" "v" "_" "dwarf")
      (ls "_" "**dot_1**")
      (tar "_" "minidwarf" "_" "dwarf")
      (ls "_" "**dot_1**")
      (info "gzip")
      (gzip "_" "minidwarf")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (pwd "_")
      (ls "_" "**dot_2**")
      (cd "code/3" "gang")
      (tar "_" "minidwarf2.tar" "_" "dwarf")
      (gzip "_" "minidwarf2.tar")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Jan21"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "code" "2")
      (ls "_" "**dot_1**")
      (ls "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (mv "mail/set" "dwarf" "mail/set" "capture.txt")
      (mv "mail/set" "dwarf" "bin/intro" "5.5.aux")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "bin/intro" "gang")
      (ls "_" "**dot_1**")
      (gzip "_" "gang")
      (cd "_" "gang")
      (ls "_" "**dot_2**")
      (cd "_" "_" "_" "_")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (tar "_" "gang.tar" "_" "gang")
      (gzip "_" "gang.tar")
      (cd "_" "**dotdot_4**")
      (cd "_" "**dotdot_5**")
      (ls "_" "**dot_6**")
      (cd "_" "**dotdot_6**")
      (pwd "_")
      (ls "_" "**dot_7**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "_" "bin")
      (ls "_" "code")
      (ls "_" "mail")
      (cd "_" "mail")
      (tar "_" "dwarf.tgz" "_" "dwarf")
      (cd "_" "intro")
      (tar "_" "dwarf.tgz" "_" "dwarf")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "2"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "ml" "intro")
      (cd "_" "mail")
      (cd "_" "intro")
      (tar "_" "2.tgz" "_" "2")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "ps"))
     :evidence
     '((find "_" "ps" "_" "_" "**dot_0**")
      (cd "_" "bin")
      (rm "_" "ps")
      (cd "code" "2")
      (cd "_" "code")
      (cd "../code" "2")
      (rm "_" "ps")
      (cd "../mail/gang" "true")
      (cd "../../mail/gang" "true")
      (rm "_" "ps")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "code" "dwarf")
      (touch "_" "joe.txt")
      (ls "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "code")
      (ls "_" "bin")
      (ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "_" "mail")
      (ls "_" "**dot_1**")
      (ls "_" "**dot_1**")
      (file "_" "README.pdf")
      (file "_" "README.PDF")
      (cd "_" "**dotdot_1**")
      (pwd "_")
      (find "_" "pgeasy.dll" "_" "_" "**dot_2**")
      (ls "mail/3/dwarf" "pgeasy.dll")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "mail")
      (ls "_" "**dot_1**")
      (tar "_" "dwarf.tar" "_" "dwarf")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (ls "_" "**dot_2**")
      (ls "_" "bin")
      (ls "bin" "gang")
      (ls "_" "mail")
      (ls "_" "code")
      (cd "_" "code")
      (tar "_" "dwarf.tar" "_" "dwarf")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (ls "_" "mail")
      (ls "mail" "linux")
      (ls "mail/linux" "2")
      (ls "mail/linux/2" "gang")
      (ls "mail" "set")
      (ls "mail/linux" "gang")
      (ls "mail/linux/gang" "true")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "tex"))
     :evidence
     '((find "_" "tex" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (tar "_" "dwarf.tar" "mail/true" "dwarf" "_" "tar(" "dwarf.tar" "mail" "dwarf")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (cd "code" "linux")
      (touch "_" "joe.txt")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      (ls "code/mickey" "pgeasy.dll")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Mar21"))
     :evidence
     '((date "_")
      (man "find")
      (date "_")
      (cal "_")
      (find "_" "_" "_" "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "mickey"))
     :evidence
     '((find "_" "mickey" "_" "_" "**dot_0**")
      (tar "_" "mickey.tar" "bin" "mickey")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (find "_" "pl" "_" "_" "**dot_0**")
      (mv "code/2" "linux" "bin/mickey" "convert.pl")
      (mv "_" "!$" "code/2" "constructor.pl")
      (ls "_" "**dot_0**")
      (mv "code/2" "linux" "_" "!")
      (mv "code/2" "linux" "mail" "accessor.pl")
      (mv "code/2" "linux" "mail/gang" "aml.pl")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (touch "bin/gang/dwarf" "joe.txt")
      (touch "mail/dwarf" "joe.txt")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((find "_" "libtool" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      (ls "bin/mickey/gang" "pgeasy.dll")
      (ls "bin/mickey/gang" "pgeasy.dll")
      ))

   (make-exp-case
     :groundtruth '((create-dir "egg_salad.exe" "2"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "2" "_" "_" "**dot_0**")
      (cd "bin/dwarf" "2")
      (mkdir "_" "egg_salad.exe")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((find "_" "a.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "ps"))
     :evidence
     '((find "_" "ps" "_" "_" "**dot_0**")
      (rm "bin/intro" "chapin-research.ps")
      (rm "bin/dwarf/linux" "5.5.ps")
      (rm "bin/gang" "aslisp1.ps")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((find "_" "c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      (ls "mail/gang/mickey" "pgeasy.dll")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "porter"))
     :evidence
     '((ping "porter" "_")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((find "_" "b.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "dwarf"))
     :evidence
     '((find "_" "eps" "_" "_" "**dot_0**")
      (mv "code/set" "dwarf" "code/set/dwarf/gang" "agent.eps")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((ls "_" "dwarf")
      (ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "miey")
      (ls "_" "**dot_2**")
      (cd "_" "mickey")
      (ls "_" "**dot_3**")
      (cd "_" "dwarf")
      (ls "_" "**dot_4**")
      (cd "_" "**dotdot_4**")
      (tar "_" "z" "**dot_5**" "dwarf" "_" "tar(" "z" "_" "dwarf.tgz")
      (tar "_" "z" "_" "dwarf.tgz" "_" "tar(" "z" "**dot_5**" "dwarf")
      (ls "_" "**dot_5**")
      (cd "_" "**dotdot_5**")
      (ls "_" "**dot_6**")
      (cd "_" "set")
      (ls "_" "**dot_7**")
      (cd "**dotdot_7**" "**dotdot_7**")
      (ls "_" "**dot_8**")
      (cd "_" "code")
      (ls "_" "**dot_9**")
      (cd "_" "3")
      (ls "_" "**dot_10**")
      (cd "**dotdot_10**" "**dotdot_10**")
      (cd "_" "mail")
      (ls "_" "**dot_12**")
      (ls "_" "2")
      (cd "_" "2")
      (tar "_" "z" "_" "dwarf.tgz" "_" "tar(" "z" "**dot_13**" "dwarf")
      (ls "_" "gang")
      (cd "**dotdot_13**" "gang")
      (ls "_" "**dot_14**")
      (ls "_" "gang")
      (cd "**dotdot_14**" "true")
      (ls "_" "**dot_15**")
      (ls "_" "lux")
      (ls "_" "linux")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "amsterdam"))
     :evidence
     '((rlogin "amsterdam")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-size-gt "50000"))
     :evidence
     '((echo "pipe" "_" "echo(is" "_" "echo(really" "_" "echo(really" "_" "echo(useful")
      (ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "intro")
      (ls "_" "**dot_2**")
      (cd "_" "**dotdot_2**")
      (ls "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "code")
      (ls "_" "**dot_5**")
      (ls "_" "**dot_5**")
      (rm "_" "aslisp1.ps")
      (ls "_" "**dot_5**")
      (rm "_" "aslisp1.ps")
      (ls "_" "**dot_5**")
      (cd "_" "**dotdot_5**")
      (ls "_" "**dot_6**")
      (cd "_" "mail")
      (ls "_" "**dot_7**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-free "slate.cs.rochester.edu:/var/mail"))
     :evidence
     '((df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "amsterdam"))
     :evidence
     '((rsh "amsterdam" "who")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "2"))
     :evidence
     '((man "ls")
      (ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (ls "_" "dwarf")
      (ls "_" "**dot_1**")
      (ls "dwarf" "true")
      (cd "**dotdot_1**" "bin")
      (ls "_" "**dot_2**")
      (cd "**dotdot_2**" "code")
      (ls "_" "**dot_3**")
      (ls "_" "intro")
      (ls "_" "set")
      (ls "set" "gang")
      (cd "**dotdot_3**" "mail")
      (ls "_" "**dot_4**")
      (cd "_" "2")
      (ls "_" "**dot_5**")
      (tar "_" "z" "_" "linux.tgz" "_" "tar(" "z" "**dot_5**" "linux")
      (tar "_" "z" "_" "mickey.tgz" "_" "tar(" "z" "**dot_5**" "mickey")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Mar21"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "mail/intro" "pg_ctl")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "mail/3" "b.c")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "ps"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "_" "code")
      (ls "_" "mail")
      (cd "_" "mail")
      (rm "_" "ps")
      (cd "_" "dwarf")
      (rm "_" "ps")
      (cd "_" "gang")
      (rm "_" "ps")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((echo "repeat")
      (ls "_" "b.c")
      (echo "interesting")
      (ls "_" "**dot_0**")
      (ls "code/dwarf" "b.c")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (mv "code" "gang" "code" "5.5.aux")
      (mv "bin/gang" "5.5.aux" "bin" "5.5.auc")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (mv "**dot_1**" "gang" "_" "5.5.aux")
      (mv "**dot_1**" "gang" "./3/true" "5.5.tex")
      (pwd "_")
      (cd "_" "gang")
      (mv "_" "**dot_2**" "./dwarf/mickey" "5.5.dvi")
      (mv "_" "**dot_2**" "../../code/dwarf" "5.5.ps")
      (cd "**dotdot_2**" "**dotdot_2**")
      (ls "_" "**dot_3**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "mickey"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "code" "gang")
      (tar "_" "z" "_" "mickey.tgz" "_" "tar(" "z" "**dot_1**" "mickey")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (mv "./gang" "dwarf" "_" "5.5.aux")
      (cd "**dotdot_1**" "code")
      (ls "_" "**dot_2**")
      (ls "_" "**dot_2**")
      (mv "../bin/gang" "dwarf" "_" "capture.txt")
      (mv "../bin/gang" "dwarf" "./gang/linux" "capture.txt")
      (cd "**dotdot_2**" "mail")
      (ls "_" "**dot_3**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "tex"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "./bin/gang/dwarf" "5.5.tex")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "a.c"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (ls "bin/true/dwarf/intro" "a.c")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "ps14.txt"))
     :evidence
     '((ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "mail" "README")
      (ls "code/linux" "gang")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "aml" "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "**dotdot_1**" "code")
      (ls "_" "**dot_2**")
      (cd "**dotdot_2**" "mail")
      (ls "_" "**dot_3**")
      (mv "**dot_3**" "gang" "linux" "aml.pl")
      (mv "**dot_3**" "gang" "dwarf/intro" "aml.config")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "gang"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "gang" "_" "_" "**dot_0**")
      (ls "/bin" "gang")
      (ls "bin" "gang")
      (tar "_" "bingang.tar.gz" "./bin" "gang")
      (tar "_" "codegang.tar.gz" "./code/mickey/dwarf" "gang")
      (tar "_" "mailgang.tar.gz" "./mail" "gang")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "linux"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (cp "mail/gang/2" "linux" "./bin/dwarf/3" "5.5.ps" "_" "cp(mail/gang/2" "linux" "./bin/mickey" "5.5.aux" "_" "cp(mail/gang/2" "linux" "./mail/gang" "5.5.dvi" "_" "cp(mail/gang/2" "linux" "./mail/gang/2" "5.5.tex")
      (mv "mail/gang/2" "linux" "./bin/dwarf/3" "5.5.ps" "_" "mv(mail/gang/2" "linux" "./bin/mickey" "5.5.aux" "_" "mv(mail/gang/2" "linux" "./mail/gang" "5.5.dvi" "_" "mv(mail/gang/2" "linux" "./mail/gang/2" "5.5.tex")
      (ls "./bin/dwarf/3" "ps")
      ))

   (make-exp-case
     :groundtruth '((create-dir "my_thesis.txt" "2"))
     :evidence
     '((find "_" "2" "_" "_" "**dot_0**")
      (mkdir "./mail/2" "my_thesis.txt")
      (find "_" "my_thesis.txt" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-dir "s2" "gang"))
     :evidence
     '((find "_" "gang" "_" "_" "**dot_0**")
      (mkdir "./mail/gang" "s2")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      (cd "mail" "dwarf")
      (du "_" "**dot_1**")
      (ls "_" "**dot_1**")
      (du "_" "**dot_1**")
      (du "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((find "_" "rl.exe" "_" "_" "**dot_0**")
      (cd "mail/dwarf/gang" "gang")
      (du "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "hoover.csug.rochester.edu:/u"))
     :evidence
     '((df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((find "_" "libtool" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "linux"))
     :evidence
     '((man "find")
      (find "_" "_" "25600" "_" "**dot_0**")
      (find "_" "linux" "_" "_" "**dot_0**")
      (ls "./mail/dwarf/set" "cas.c")
      (find "_" "_" "50" "_" "**dot_0**")
      (ls "./mail/linux/true" "capture.txt")
      (ls "./mail/dwarf/2/mickey/dwarf" "5.5.aux")
      (mv "./mail" "linux" "./mail/linux/true" "capture.txt" "_" "mv(./mail" "linux" "./mail/dwarf/2/mickey/dwarf" "5.5.aux")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "dwarf"))
     :evidence
     '((find "_" "eps" "_" "_" "**dot_0**")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (mv "./bin/gang" "dwarf" "./bin/gang/set" "agent.eps")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "linux"))
     :evidence
     '((find "_" "_" "75" "_" "**dot_0**")
      (ls "mail" "linux")
      (ls "mail" "linux")
      (mv "mail" "linux" "./mail" "capture.txt" "_" "mv(mail" "linux" "./mail/dwarf/gang" "5.5.aux")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "pl"))
     :evidence
     '((find "_" "pl" "_" "_" "**dot_0**")
      (rm "./code/dwarf/dwarf" "convert.pl" "_" "rm(./mail/intro" "constructor.pl" "_" "rm(./mail/intro" "aml.pl" "_" "rm(./mail/intro" "accessor.pl")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-size-gt "40000"))
     :evidence
     '((find "_" "_" "40000" "_" "**dot_0**")
      (rm "./mail/gang/dwarf" "aslisp1.ps" "_" "rm(./mail/gang/2/set" "chapin-research.ps" "_" "rm(./mail/gang/linux" "cycle.tiff")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "nye"))
     :evidence
     '((ping "nye" "_")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "ps14.txt"))
     :evidence
     '((find "_" "ps14.txt" "_" "_" "**dot_0**")
      (cd "code" "2")
      (du "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      (cd "_" "bin")
      (du "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "canberra"))
     :evidence
     '((ping "canberra" "_")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "*README*" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((find "_" "c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((copy-files-by-attr-size-lt "50" "linux"))
     :evidence
     '((man "find")
      (ls "_" "**dot_0**")
      (find "_" "*linux*" "_" "_" "**dot_0**")
      (ls "_" "bin")
      (ls "_" "bin")
      (ls "_" "code")
      (ls "_" "mail")
      (cd "_" "code")
      (ls "_" "2")
      (cp "../co/gang" "linux" "_" "5.5.aux")
      (ls "_" "**dot_1**")
      (cp "../code/gang" "linux" "2" "5.5.aux")
      (ls "_" "dwarf")
      (ls "2" "dwarf")
      (ls "_" "gang")
      (ls "_" "gang" "_" "ls(" "linux")
      (ls "gang" "linux")
      (ls "gang" "true")
      (pwd "_")
      (ls "_" "**dot_1**")
      (ls "_" "set")
      (ls "set" "intro")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (cd "_" "mail")
      (ls "_" "**dot_3**")
      (cd "_" "dwarf")
      (ls "_" "**dot_4**")
      (cd "_" "3")
      (ls "_" "**dot_5**")
      (cd "**dotdot_5**" "gang")
      (ls "_" "**dot_6**")
      (cd "_" "**dotdot_6**")
      (ls "_" "**dot_7**")
      (cd "_" "**dotdot_7**")
      (ls "_" "**dot_8**")
      (cd "_" "mickey")
      (ls "_" "**dot_9**")
      (cd "_" "gang")
      (ls "_" "**dot_10**")
      (pwd "_")
      (cp "../../code/gang" "linux" "_" "capture.txt")
      (find "_" "_" "_" "**dotdot_10**" "**dotdot_10**" "_" "find(" "_" "_" "_" "*linux*")
      (find "_" "*linux*" "_" "../.." "**dotdot_10**")
      (ls "_" "**dot_10**")
      (cp "../../../code/gang" "linux" "_" "capture.txt")
      (cd "_" "**dotdot_10**")
      (ls "_" "**dot_11**")
      (cd "_" "**dotdot_11**")
      (ls "_" "**dot_12**")
      (cd "_" "**dotdot_12**")
      (ls "_" "**dot_13**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "linux"))
     :evidence
     '((find "_" "*linux*" "_" "_" "**dot_0**")
      (find "_" "ps" "_" "_" "**dot_0**")
      (mv "./mail" "linux" "./bin/gang/intro" "5.5.ps")
      (mv "./mail" "linux" "./bin/gang/gang" "aslisp1.ps")
      (mv "./mail" "linux" "./mail/3/gang" "chapin-research.ps")
      (find "_" "ps" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-free "slate.cs.rochester.edu:/var/mail"))
     :evidence
     '((df "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      (ls "./code/dwarf/3" "pgeasy.dll")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "2"))
     :evidence
     '((find "_" "2" "_" "_" "**dot_0**")
      (cd "code/mickey" "2")
      (ls "_" "**dot_1**")
      (compress "_" "gang")
      (ls "_" "**dot_1**")
      (ls "_" "gang")
      (man "compress")
      (ls "_" "**dot_1**")
      (pwd "_")
      (compress "_" "gang")
      (ls "_" "gang")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "dwarf"))
     :evidence
     '((find "_" "dwarf" "_" "_" "**dot_0**")
      (find "_" "ps" "_" "_" "**dot_0**")
      (mv "./mail/gang" "dwarf" "./bin/gang/intro" "chapin-research.ps")
      (mv "./mail/gang" "dwarf" "./code/2/set" "aslisp1.ps")
      (mv "./mail/gang" "dwarf" "./code/2/set" "5.5.ps")
      (find "_" "ps" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "pgeasy.dll"))
     :evidence
     '((find "_" "pgeasy.dll" "_" "_" "**dot_0**")
      (ls "./mail/gang" "pgeasy.dll")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-date-modification-exact "Mar21"))
     :evidence
     '((man "find")
      (date "_")
      (find "_" "_" "_" "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**")
      (find "_" "_" "_" "_" "**dot_0**" "_" "find(" "_" "_" "_" "-ctime")
      (find "_" "_" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "5.5"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      (find "_" "5.5" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-size-gt "50000"))
     :evidence
     '((du "_" "**dot_0**")
      (sort "_" "t")
      (cat "_" "tt")
      (rm "./bin/3" "gang" "_" "rm(./bin/3/2" "dwarf" "_" "rm(./code/dwarf" "linux" "_" "rm(./mail" "set" "_" "rm(./code" "dwarf" "_" "rm(./mail" "intro" "_" "rm(./code/mickey" "gang" "_" "rm(./bin/3" "2" "_" "rm(./bin" "3")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "linux"))
     :evidence
     '((find "_" "ps" "_" "_" "**dot_0**")
      (mv "_" "linux" "./bin/dwarf" "aslisp1.ps" "_" "mv(" "linux" "./code/gang/intro" "chapin-research.ps" "_" "mv(" "linux" "./mail/2/set" "5.5.ps")
      (ls "_" "linux")
      (pwd "_")
      (ls "_" "**dot_0**")
      (mkdir "_" "linux")
      (mv "_" "linux" "./bin/dwarf" "aslisp1.ps" "_" "mv(" "linux" "./code/gang/intro" "chapin-research.ps" "_" "mv(" "linux" "./mail/2/set" "5.5.ps")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((ls "_" "lib")
      (ls "_" "**dot_0**")
      (ls "*" "lib")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "intro")
      (ls "_" "**dot_2**")
      (cd "_" "**dotdot_2**")
      (cd "_" "set")
      (ls "_" "**dot_4**")
      (cd "_" "gang")
      (ls "_" "**dot_5**")
      (cd "**dotdot_5**" "**dotdot_5**")
      (ls "_" "**dot_6**")
      (cd "_" "**dotdot_6**")
      (ls "_" "**dot_7**")
      (cd "_" "code")
      (ls "_" "**dot_8**")
      (cd "_" "gang")
      (ls "_" "**dot_9**")
      (cd "_" "true")
      (ls "_" "**dot_10**")
      (cd "**dotdot_10**" "**dotdot_10**")
      (ls "_" "**dot_11**")
      (cd "_" "**dotdot_11**")
      (ls "_" "**dot_12**")
      (cd "_" "mail")
      (ls "_" "**dot_13**")
      (cd "_" "2")
      (ls "_" "**dot_14**")
      (cd "_" "3")
      (ls "_" "**dot_15**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "mail")
      (ls "_" "**dot_1**")
      (cd "_" "gang")
      (ls "_" "**dot_2**")
      (ls "_" "mickey")
      (ls "_" "dwarf")
      (mv "_" "linux" "dwarf" "5.5.ps")
      (ls "_" "2")
      (ls "2" "dwarf")
      (pwd "_")
      (cd "_" "**dotdot_2**")
      (ls "_" "**dot_3**")
      (ls "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "code")
      (ls "_" "**dot_5**")
      (mv "../mail" "linux" "_" "chap")
      (ls "_" "**dot_5**")
      (cd "_" "gang")
      (ls "_" "**dot_6**")
      (cd "**dotdot_6**" "**dotdot_6**")
      (ls "_" "**dot_7**")
      (cd "_" "bin")
      (ls "_" "**dot_8**")
      (mv "../mail" "linux" "_" "ps")
      (ls "_" "**dot_8**")
      (cd "_" "gang")
      (ls "_" "**dot_9**")
      (cd "_" "3")
      (ls "_" "**dot_10**")
      (cd "_" "**dotdot_10**")
      (cd "_" "set")
      (ls "_" "**dot_12**")
      (cd "_" "**dotdot_12**")
      (ls "_" "**dot_13**")
      (cd "_" "**dotdot_13**")
      (ls "_" "**dot_14**")
      (cd "_" "intro")
      (ls "_" "**dot_15**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "ps14.txt"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "2")
      (ls "_" "**dot_2**")
      (cd "_" "intro")
      (ls "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "**dotdot_4**")
      (cd "_" "dwarf")
      (ls "_" "**dot_6**")
      (cd "_" "**dotdot_6**")
      (ls "_" "**dot_7**")
      (cd "_" "**dotdot_7**")
      (ls "_" "**dot_8**")
      (cd "_" "code")
      (ls "_" "**dot_9**")
      (cd "_" "gang")
      (ls "_" "**dot_10**")
      (cd "_" "dward")
      (ls "_" "**dot_11**")
      (cd "_" "dwarf")
      (ls "_" "**dot_12**")
      (cd "_" "2")
      (cd "_" "2")
      (cd "_" "3")
      (ls "_" "**dot_15**")
      (cd "_" "**dotdot_15**")
      (ls "_" "**dot_16**")
      (cd "_" "**dotdot_16**")
      (ls "_" "**dot_17**")
      (cd "_" "**dotdot_17**")
      (ls "_" "**dot_18**")
      (cd "_" "**dotdot_18**")
      (ls "_" "**dot_19**")
      (cd "_" "mail")
      (ls "_" "**dot_20**")
      (cd "_" "gang")
      (ls "_" "**dot_21**")
      (ls "_" "gang")
      (cd "_" "gang")
      (ls "_" "ps14")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "bin")
      (ls "bin" "intro")
      (ls "_" "code")
      (ls "code" "gang")
      (ls "code/gang" "gang")
      (ls "code/gang" "true")
      (ls "_" "**dot_0**")
      (cd "_" "mail")
      (ls "_" "**dot_1**")
      (ls "_" "2")
      (mv "../code/gang" "dwarf" "2" "eps")
      (ls "2" "set")
      (ls "_" "gang")
      (ls "_" "**dot_1**")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "linux")
      (ls "_" "**dot_2**")
      (cd "**dotdot_2**" "true")
      (ls "_" "**dot_3**")
      (cd "_" "gang")
      (ls "_" "**dot_4**")
      (cd "_" "intro")
      (ls "_" "**dot_5**")
      (cd "**dotdot_5**" "**dotdot_5**")
      (ls "_" "**dot_6**")
      (cd "_" "**dotdot_6**")
      (ls "_" "**dot_7**")
      (cd "_" "**dotdot_7**")
      (ls "_" "**dot_8**")
      (cd "_" "code")
      (ls "_" "**dot_9**")
      (cd "_" "**dotdot_9**")
      (cd "_" "mail")
      (ls "_" "**dot_11**")
      (cd "_" "2")
      (ls "_" "**dot_12**")
      (cd "_" "dwarf")
      (ls "_" "**dot_13**")
      (tar "_" "z" "set" "**dot_13**")
      (ls "_" "set")
      (which "zip")
      (zip "_" "set.zip" "set" "**dot_13**")
      (ls "_" "**dot_13**")
      (cd "_" "**dotdot_13**")
      (ls "_" "**dot_14**")
      (cd "_" "gang")
      (ls "_" "**dot_15**")
      (cd "_" "**dotdot_15**")
      (ls "_" "**dot_16**")
      (cd "_" "**dotdot_16**")
      (ls "_" "**dot_17**")
      (cd "_" "dwarf")
      (ls "_" "**dot_18**")
      (cd "_" "**dotdot_18**")
      (cd "_" "gang")
      (ls "_" "**dot_20**")
      (cd "_" "**dotdot_20**")
      (cd "_" "mickey")
      (ls "_" "**dot_22**")
      (cd "_" "3")
      (ls "_" "**dot_23**")
      (cd "../.." "**dotdot_23**")
      (ls "_" "**dot_24**")
      (cd "_" "mail")
      (ls "_" "**dot_25**")
      (cd "_" "2")
      (ls "_" "**dot_26**")
      (cd "_" "dwarf")
      (ls "_" "**dot_27**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-free "slate.cs.rochester.edu:/var/mail"))
     :evidence
     '((df "/var" "mail")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (touch "bin/linux" "bob.bob")
      (ls "bin" "linux")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((touch "bin/linux" "bob.bob")
      (find "_" "linux" "_" "_" "**dot_0**")
      (touch "code/mickey/dwarf/linux" "bob.bob")
      (ls "code/mickey/dwarf" "linux")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "maputo"))
     :evidence
     '((rlogin "maputo")
      ))

   (make-exp-case
     :groundtruth '((create-dir "egg_salad.exe" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "_" "gang")
      (ls "_" "**dot_2**")
      (cd "_" "lunux")
      (cd "_" "linux")
      (mkdir "_" "egg_salad.exe")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "_" "dwarf")
      (ls "_" "**dot_2**")
      (touch "_" "bob.bob")
      (ls "_" "**dot_2**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "vax1.cs.rochester.edu:/home/vax1/u"))
     :evidence
     '((cd "/home" "vax1")
      (du "_" "u")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-partition "slate.cs.rochester.edu:/var/mail"))
     :evidence
     '((cd "_" "var")
      (ls "_" "**dot_1**")
      (du "_" "mail")
      (du "_" "mail")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "5.5"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "_" "gang")
      (ls "_" "**dot_2**")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "il/gang" "dwarf")
      (cd "_" "mail")
      (cd "_" "gang")
      (cd "_" "dwarf")
      (ls "_" "**dot_4**")
      (touch "_" "joe.txt")
      (ls "_" "**dot_4**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((ls "_" "**dot_0**")
      (find "_" "libtool" "_" "_" "**dot_0**")
      (find "_" "libtool" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (find "_" "libtool" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "code" "linux")
      (ls "_" "**dot_1**")
      (less "_" "libtool.txt")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (pwd "_")
      (du "_" "**dot_0**")
      (du "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (ls "_" "**dot_2**")
      (ls "_" "**dot_2**")
      (ls "_" "**dot_2**")
      (mv "mail/gang/dwarf" "linux" "code/2/mickey" "5.5.aux")
      (ls "_" "**dot_2**")
      (cd "_" "mail")
      (ls "_" "**dot_3**")
      (ls "_" "**dot_3**")
      (mv "mail/gang/dwarf" "linux" "_" "capture.txt")
      (ls "_" "**dot_3**")
      (mv "**dotdot_3**" "mail" "_" "capture.txt")
      (mv "gang/dwarf" "linux" "_" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-free "slate.cs.rochester.edu:/var/mail"))
     :evidence
     '((rlogin "slate")
      (cd "_" "var")
      (cd "_" "slate")
      (cd "_" "var")
      (ls "_" "**dot_3**")
      (pwd "_")
      (cd "_" "mail")
      (ls "_" "**dot_4**")
      (cd "_" "**dotdot_4**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "ps" "dwarf"))
     :evidence
     '((pwd "_")
      (ls "_" "ps")
      (ls "_" "ps" "_" "ls(" "**dot_0**")
      (ls "_" "**dot_0**")
      (ls "_" "ps")
      (mv "/mail" "dwarf" "/bin/mickey/gang" "aslisp1.ps")
      (pwd "_")
      (mv "/mail" "dwarf" "bin/mickey/gang" "aslisp1.ps")
      (mv "mail" "dwarf" "bin/mickey/gang" "aslisp1.ps")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "b.c"))
     :evidence
     '((find "_" "b.c" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "**dotdot_1**" "code")
      (ls "_" "**dot_2**")
      (ls "_" "dwarf")
      (ls "dwarf" "dwarf")
      (ls "dwarf/dwarf" "true")
      (ls "_" "gang")
      (cd "_" "gang")
      (ls "_" "intro")
      (ls "_" "set")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "**dotdot_4**")
      (ls "_" "**dot_5**")
      (cd "_" "mail")
      (ls "_" "**dot_6**")
      (cd "_" "2")
      (ls "_" "**dot_7**")
      (cd "_" "linux")
      (vi "_" "bob.bob")
      (ls "_" "**dot_8**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "pl" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "2")
      (ls "_" "**dot_2**")
      (ls "_" "intro")
      (ls "_" "mickey")
      (cd "**dotdot_2**" "**dotdot_2**")
      (ls "_" "**dot_3**")
      (cd "bin" "linux")
      (ls "_" "**dot_4**")
      (cd "_" "gang")
      (ls "_" "**dot_5**")
      (cd "_" "**dotdot_5**")
      (ls "_" "**dot_6**")
      (cd "_" "**dotdot_6**")
      (ls "_" "**dot_7**")
      (cd "_" "**dotdot_7**")
      (ls "_" "**dot_8**")
      (cd "_" "code")
      (ls "_" "**dot_9**")
      (ls "_" "true")
      (ls "_" "3")
      (cd "_" "true")
      (ls "_" "2")
      (ls "_" "3")
      (ls "_" "gang")
      (ls "gang" "gang")
      (cd "_" "**dotdot_10**")
      (ls "_" "**dot_11**")
      (cd "_" "**dotdot_11**")
      (ls "_" "**dot_12**")
      (cd "_" "mail")
      (ls "_" "**dot_13**")
      (ls "_" "set")
      (cp "_" "dwarf" "set" "pl")
      (ls "_" "**dot_13**")
      (ls "_" "dwarf")
      (ls "dwarf" "dwarf")
      (ls "_" "**dot_13**")
      (cd "_" "**dotdot_13**")
      (ls "_" "**dot_14**")
      (cd "_" "code")
      (ls "_" "**dot_15**")
      (cd "_" "trye")
      (cd "_" "true")
      (ls "_" "**dot_17**")
      (cd "_" "gang")
      (ls "_" "**dot_18**")
      (cd "_" "gang")
      (ls "_" "**dot_19**")
      (cd "../.." "3")
      (ls "_" "**dot_20**")
      (cd "_" "**dotdot_20**")
      (ls "_" "**dot_21**")
      (cp "../mail" "dwarf" "_" "aml.pl")
      (cp "../../mail" "dwarf" "_" "aml.pl")
      ))

   (make-exp-case
     :groundtruth '((create-file "bob.bob" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "_" "true")
      (ls "_" "**dot_2**")
      (cd "_" "**dotdot_2**")
      (ls "_" "**dot_3**")
      (cd "_" "**dotdot_3**")
      (ls "_" "**dot_4**")
      (cd "_" "code")
      (ls "_" "**dot_5**")
      (cd "_" "**dotdot_5**")
      (ls "_" "**dot_6**")
      (cd "_" "bin")
      (ls "_" "**dot_7**")
      (cd "_" "intro")
      (ls "_" "**dot_8**")
      (cd "_" "**dotdot_8**")
      (ls "_" "**dot_9**")
      (cd "_" "**dotdot_9**")
      (ls "_" "**dot_10**")
      (find "_" "linux" "_" "_" "**dot_10**")
      (find "_" "linux" "_" "_" "**dot_10**")
      (cd "code/true/2" "linux")
      (ls "_" "**dotdot_11**")
      (cp "_" "**dot_11**" "**dotdot_11**" "capture.txt")
      (mv "_" "bob.bob" "_" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "5.5"))
     :evidence
     '((find "_" "5.5" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "50" "linux"))
     :evidence
     '((find "_" "linux" "_" "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (mv "mail" "linux" "bin/gang/set" "5.5.aux")
      (mv "mail" "linux" "mail/linux/gang" "capture.txt")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((compress "_" "dwarf")
      (ls "_" "**dot_0**")
      (compress "_" "**dot_0**")
      (compress "_" "dwarf")
      (ls "_" "code")
      (ls "_" "mail")
      (compress "_" "dwarf")
      (compress "code" "dwarf")
      (ls "_" "**dot_0**")
      (compress "mail" "dwarf")
      (ls "_" "bin")
      (ls "bin" "2")
      (ls "bin/2" "mickey")
      (ls "_" "mail")
      (ls "mail" "set")
      (compress "mail/set" "swarf")
      (compress "mail/set" "dwarf")
      (ls "_" "code")
      (ls "code" "3")
      (ls "code" "gang")
      (ls "code/gang" "gang")
      (ls "_" "code" "_" "ls(gang" "intro")
      (ls "code" "true")
      (ls "code/true" "linux")
      ))

   (make-exp-case
     :groundtruth '((create-file "joe.txt" "dwarf"))
     :evidence
     '((vi "dwarf" "joe.txt")
      ))

   (make-exp-case
     :groundtruth '((determine-machine-connected-alive "amsterdam"))
     :evidence
     '((ping "amsterdam" "_")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((ls "_" "rl.exe")
      (ls "_" "**dot_0**")
      (ls "_" "**dot_0**")
      (cd "_" "bin")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      (tree "_" "**dot_2**")
      (cd "_" "code")
      (ls "_" "**dot_3**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-size-lt "75" "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (tree "_" "**dot_0**")
      (cd "mail" "intro")
      (ls "_" "**dot_1**")
      (cd "_" "dwarf")
      (ls "_" "**dot_2**")
      (ls "_" "**dot_2**")
      (cd "_" "gang")
      (ls "_" "**dot_3**")
      (ls "_" "**dot_3**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "gang"))
     :evidence
     '((cd "mail/intro/dwarf" "gang")
      (cd "_" "mail")
      (ls "_" "**dot_2**")
      (cd "_" "gang")
      (ls "_" "**dot_3**")
      (cd "_" "gang")
      (ls "_" "**dot_4**")
      (pwd "_")
      (cd "_" "**dot_4**")
      (pwd "_")
      (ls "_" "**dot_5**")
      (cd "/home/vax2/u23/blaylock/Experiment/Playground" "wyi_20030422_104305")
      (ls "_" "**dot_6**")
      (tree "_" "**dot_6**")
      (cp "mail/gang" "gang" "bin" "5.5")
      (cp "mail/gang" "gang" "code/dwarf/2" "5.5")
      (cp "mail/gang" "gang" "mail/3" "5.5")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-stem "5.5" "linux"))
     :evidence
     '((ls "_" "**dot_0**")
      (mv "_" "linux" "_" "5.5")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((find "_" "libtool" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-attr-name "dwarf"))
     :evidence
     '((ls "_" "**dot_0**")
      (cd "_" "code")
      (ls "_" "**dot_1**")
      (mkdir "_" "linux")
      (mv "_" "linux" "_" "5.5")
      (ls "_" "**dot_1**")
      (find "_" "libtool" "_" "_" "**dot_1**")
      (find "_" "libtool" "_" "_" "**dot_1**")
      (find "_" "libtool" "_" "_" "**dot_1**")
      (tar "_" "test.tar" "_" "dwarf")
      (ls "_" "**dot_1**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-stem "libtool"))
     :evidence
     '((cd "_" "code")
      (ls "_" "**dot_1**")
      (cd "_" "**dotdot_1**")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-ext "c"))
     :evidence
     '((ls "_" "c")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "README" "_" "*" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((know-filespace-usage-file "rl.exe"))
     :evidence
     '((find "_" "rl.exe" "_" "*" "**dot_0**")
      (ls "code" "rl.exe")
      ))

   (make-exp-case
     :groundtruth '((find-file-by-attr-name-exact "README"))
     :evidence
     '((find "_" "README" "_" "*" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((move-files-by-attr-name-ext "eps" "dwarf"))
     :evidence
     '((find "_" "eps" "_" "*" "**dot_0**")
      (mv "_" "dwarf" "bin/2" "agent.eps")
      (find "_" "dwarf" "_" "_" "**dot_0**")
      (mv "code/dwarf" "**dot_0**" "bin/2" "agent.eps")
      ))

   (make-exp-case
     :groundtruth '((remove-files-by-attr-name-ext "ps"))
     :evidence
     '((find "_" "ps" "_" "*" "**dot_0**")
      (find "_" "ps" "_" "_" "**dot_0**")
      ))

   (make-exp-case
     :groundtruth '((compress-dirs-by-loc-dir "gang"))
     :evidence
     '((find "_" "gang" "_" "*" "**dot_0**")
      (gzip "bin" "gang")
      (gzip "bin/true" "gang")
      (gzip "bin/true/2" "gang")
      ))))

