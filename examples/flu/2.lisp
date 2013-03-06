(clearmem)

(create-rules 
(:consequent ((isa ?m meeting) (isrel ?am at)
              (participant ?am ?p1) (meeting ?am ?m))
 :antecedent ((isa ?p1 person) (MEMBER ?P1 ?PROJECT) (PAID-FROM ?P1 ?PROJECT)
              (isa ?project PROJECT)))

(:consequent ((isa ?f1 flu) (isrel ?hs3 has) (owner ?hs3 ?p1) (owned ?hs3 ?f1))
 :antecedent ((isa ?p1 person) (isa ?s1 fever) (isa ?s2 cough) (isrel ?hs1 has)
	      (owner ?hs1 ?p1) (owned ?hs1 ?s1) (isrel ?hs2 has) (owner ?hs2 ?p1)
	      (owned ?hs2 ?s2)))

(:consequent ((isa ?f1 food-poisoning) (isrel ?hs3 has) (owner ?hs3 ?p1) (owned ?hs3 ?f1))
 :antecedent ((isa ?p1 person) (isa ?s1 fever) (isa ?s2 vomiting) (isrel ?hs1 has)
	      (owner ?hs1 ?p1) (owned ?hs1 ?s1) (isrel ?hs2 has) (owner ?hs2 ?p1)
	      (owned ?hs2 ?s2)))

(:consequent ((isa ?f1 lung-cancer) (isrel ?hs3 has) (owner ?hs3 ?p1) (owned ?hs3 ?f1))
 :antecedent ((isa ?p1 person) (isa ?s1 yellow-teeth) (isa ?s2 cough) (isrel ?hs1 has)
	      (owner ?hs1 ?p1) (owned ?hs1 ?s1) (isrel ?hs2 has) (owner ?hs2 ?p1)
	      (owned ?hs2 ?s2)))

(:consequent ((isa ?f3 flu) (isrel ?c1 caught-from) (caught-obj ?c1 ?f3) (catcher ?c1 ?p2) (thrower ?c1 ?p1))
 :antecedent ((isa ?m meeting) (isrel ?am1 at) (participant ?am1 ?p1) (meeting ?am1 ?m)
	                       (isrel ?am2 at) (participant ?am2 ?p2) (meeting ?am2 ?m)
	      (isa ?p1 person) (isa ?p2 person)
	      (isa ?f1 flu) (isrel ?hs1 has) (owner ?hs1 ?p1) (owned ?hs1 ?f1)
	      (isa ?f2 flu) (isrel ?hs2 has) (owner ?hs2 ?p2) (owned ?hs2 ?f2))))

(defevidence 
(isa p1 person)
(isa p2 person)
(name p1 abe)
(name p2 bob)
(isa j1 project)
(name j1 muri-project)
(member p1 j1)
(member p2 j1)
(isa s1 cough)
(isa s2 fever)
(isrel h1 has)
(isrel h2 has)
(owner h1 p1)
(owned h1 s1)
(owner h2 p2)
(owned h2 s2))

;; 9/8/11 BUG. bindability is checked only for the explained belief
;; and not for existing literals in a justification. this leads to
;; weird situations like (isa s1 flu), which could only happen if
;; cough is replaced by flu during the binding process.

(defun test-flu (steps &optional (pb #'pick-belief-fewrules-unattached))
  (test-one steps *evidence* *rules* pb))

(defun inc-test-flu (steps  &optional (plot? nil) (pb #'pick-belief-fewrules-unattached))
  (inc-test-one steps *evidence* *rules* plot? pb))

#|
0: (BIND-JUSTIFICATION
      (JNEW: ((ISA SK1 MEETING) (ISREL SK2 AT) (PARTICIPANT SK2 SK3)
              (MEETING SK2 SK1) (ISA SK1 MEETING) (ISREL SK4 AT)
              (PARTICIPANT SK4 SK5) (MEETING SK4 SK1) (ISA SK3 PERSON)
              (ISA SK5 PERSON) (ISA SK6 FLU) (ISREL SK7 HAS) (OWNER SK7 SK3)
              (OWNED SK7 SK6) (ISA SK8 FLU) (ISREL SK9 HAS) (OWNER SK9 SK5)
              (OWNED SK9 SK8)) => ((ISREL SK10 CAUGHT-FROM) (CAUGHT-OBJ SK11)
                                   (ISA SK11 FLU) (CATCHER SK5) (THROWER SK3)))
      (B1 (OWNED H2 S2)) #W:W1(SELF.B) #<WM {1004367341}>)

  0: BIND-JUSTIFICATION returned
       (((JNEW: ((ISA SK1 MEETING) (ISREL SK2 AT) (PARTICIPANT SK2 SK3)
                 (MEETING SK2 SK1) (ISA SK1 MEETING) (ISREL SK4 AT)
                 (PARTICIPANT SK4 SK5) (MEETING SK4 SK1) (ISA SK3 PERSON)
                 (ISA SK5 PERSON) (ISA SK6 FLU) (ISREL SK7 HAS) (OWNER SK7 SK3)
                 (OWNED SK7 SK6) (ISA S2 FLU) (ISREL H2 HAS) (OWNER H2 SK5)
                 (OWNED H2 S2)) => ((ISREL SK10 CAUGHT-FROM) (CAUGHT-OBJ SK11)
                                    (ISA SK11 FLU) (CATCHER SK5)
                                    (THROWER SK3)))
         (B1 (OWNED H2 S2)) #W:W1(SELF.B))
        ((JNEW: ((ISA SK1 MEETING) (ISREL SK2 AT) (PARTICIPANT SK2 SK3)
                 (MEETING SK2 SK1) (ISA SK1 MEETING) (ISREL SK4 AT)
                 (PARTICIPANT SK4 SK5) (MEETING SK4 SK1) (ISA SK3 PERSON)
                 (ISA SK5 PERSON) (ISA S2 FLU) (ISREL H2 HAS) (OWNER H2 SK3)
                 (OWNED H2 S2) (ISA SK8 FLU) (ISREL SK9 HAS) (OWNER SK9 SK5)
                 (OWNED SK9 SK8)) => ((ISREL SK10 CAUGHT-FROM)
                                      (CAUGHT-OBJ SK11) (ISA SK11 FLU)
                                      (CATCHER SK5) (THROWER SK3)))
         (B1 (OWNED H2 S2)) #W:W1(SELF.B)))
|#