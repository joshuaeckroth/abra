(setq *cases* (list
               (make-exp-case
                ;; Seed: 8791825
                :groundtruth '(
                               (mov 8 1 7 0 9 10 "#ff4d0978")
                               (mov 3 2 5 4 1 2 "#ff3b5002")
                               (mov 4 1 5 2 4 5 "#ff4d0978")
                               (mov 7 9 8 8 5 6 "#ff792bb8")
                               (mov 2 8 4 8 0 1 "#ff06d699")
                               (mov 5 5 6 4 4 5 "#ff06d699")
                               (mov 7 6 8 7 4 5 "#ff3b5002")
                               (mov 2 0 4 0 3 4 "#ff4aecb5")
                               (mov 6 2 7 5 5 6 "#ff4aecb5")
                               (mov 6 8 4 8 7 8 "#ff792bb8")
                               (mov 6 6 9 7 0 1 "#ff792bb8")
                               (mov 9 7 6 8 1 2 "#ff792bb8")
                               (mov 8 4 6 4 7 8 "#ff4aecb5")
                               (mov 7 5 8 6 8 9 "#ff06d699")
                               (mov 7 0 8 1 8 9 "#ff4d0978")
                               (mov 7 7 6 8 3 4 "#ff792bb8")
                               (mov 8 4 7 3 9 10 "#ff4aecb5")
                               (mov 5 0 3 2 0 1 "#ff3b5002")
                               (mov 4 0 6 2 4 5 "#ff4aecb5")
                               (mov 2 6 1 5 2 3 "#ff06d699")
                               (mov 9 8 7 8 6 7 "#ff3b5002")
                               (mov 5 4 6 5 2 3 "#ff3b5002")
                               (mov 6 3 3 6 2 3 "#ff4d0978")
                               (mov 5 2 8 1 5 6 "#ff4d0978")
                               (mov 7 7 9 5 6 7 "#ff06d699")
                               (mov 6 8 7 9 4 5 "#ff792bb8")
                               (mov 5 2 6 3 1 2 "#ff4d0978")
                               (mov 6 5 7 6 3 4 "#ff3b5002")
                               (mov 4 4 4 6 9 10 "#ff792bb8")
                               (mov 6 4 8 4 8 9 "#ff4aecb5")
                               (mov 4 8 2 6 1 2 "#ff06d699")
                               (mov 3 8 5 8 9 10 "#ff3b5002")
                               (mov 8 8 6 8 6 7 "#ff792bb8")
                               (mov 8 7 9 8 5 6 "#ff3b5002")
                               (mov 5 6 5 2 0 1 "#ff4d0978")
                               (mov 3 6 4 1 3 4 "#ff4d0978")
                               (mov 8 1 9 2 6 7 "#ff4d0978")
                               (mov 2 4 0 4 0 1 "#ff4aecb5")
                               (mov 1 5 5 5 3 4 "#ff06d699")
                               (mov 8 6 7 5 9 10 "#ff06d699")
                               (mov 7 8 5 8 7 8 "#ff3b5002")
                               (mov 9 2 7 0 7 8 "#ff4d0978")
                               (mov 6 8 7 7 2 3 "#ff792bb8")
                               (mov 0 4 0 2 1 2 "#ff4aecb5")
                               (mov 0 2 2 0 2 3 "#ff4aecb5")
                               (mov 6 4 7 7 5 6 "#ff06d699")
                               (mov 9 5 7 5 7 8 "#ff06d699")
                               (mov 5 8 3 8 8 9 "#ff3b5002")
                               (mov 4 8 4 4 8 9 "#ff792bb8")
                               (mov 7 5 8 4 6 7 "#ff4aecb5")
                               )
                :evidence '(
                            (next-time-step 0 1)
                            (det-a 6 6 0)
                            (det-a 5 6 0)
                            (det-a 2 4 0)
                            (obj-color 2 8 0 "#ff06d699")
                            (det-a 2 8 0)
                            (obj-color 5 0 0 "#ff3b5002")
                            (det-a 5 0 0)
                            (next-time-step 1 2)
                            (det-a 9 7 1)
                            (det-b 9 7 1)
                            (det-a 0 4 1)
                            (det-b 0 4 1)
                            (obj-color 4 8 1 "#ff06d699")
                            (det-a 4 8 1)
                            (det-b 4 8 1)
                            (obj-color 5 2 1 "#ff4d0978")
                            (det-a 5 2 1)
                            (det-b 5 2 1)
                            (obj-color 3 2 1 "#ff3b5002")
                            (det-a 3 2 1)
                            (det-b 3 2 1)
                            (next-time-step 2 3)
                            (det-a 6 3 2)
                            (det-b 6 3 2)
                            (det-a 5 4 2)
                            (det-b 5 4 2)
                            (det-a 2 6 2)
                            (det-b 2 6 2)
                            (obj-color 6 8 2 "#ff792bb8")
                            (det-a 6 8 2)
                            (det-b 6 8 2)
                            (obj-color 0 2 2 "#ff4aecb5")
                            (det-a 0 2 2)
                            (det-b 0 2 2)
                            (next-time-step 3 4)
                            (det-a 7 7 3)
                            (det-b 7 7 3)
                            (det-a 6 5 3)
                            (det-b 6 5 3)
                            (det-a 3 6 3)
                            (det-b 3 6 3)
                            (det-a 1 5 3)
                            (det-b 1 5 3)
                            (obj-color 2 0 3 "#ff4aecb5")
                            (det-a 2 0 3)
                            (det-b 2 0 3)
                            (next-time-step 4 5)
                            (det-a 7 6 4)
                            (det-b 7 6 4)
                            (det-a 5 5 4)
                            (det-b 5 5 4)
                            (obj-color 6 8 4 "#ff792bb8")
                            (det-a 6 8 4)
                            (det-b 6 8 4)
                            (obj-color 4 1 4 "#ff4d0978")
                            (det-a 4 1 4)
                            (det-b 4 1 4)
                            (obj-color 4 0 4 "#ff4aecb5")
                            (det-a 4 0 4)
                            (det-b 4 0 4)
                            (next-time-step 5 6)
                            (det-a 8 7 5)
                            (det-b 8 7 5)
                            (det-a 6 4 5)
                            (det-b 6 4 5)
                            (obj-color 7 9 5 "#ff792bb8")
                            (det-a 7 9 5)
                            (det-b 7 9 5)
                            (obj-color 6 2 5 "#ff4aecb5")
                            (det-a 6 2 5)
                            (det-b 6 2 5)
                            (obj-color 5 2 5 "#ff4d0978")
                            (det-a 5 2 5)
                            (det-b 5 2 5)
                            (next-time-step 6 7)
                            (det-a 7 7 6)
                            (det-b 7 7 6)
                            (det-a 7 5 6)
                            (det-b 7 5 6)
                            (obj-color 9 8 6 "#ff3b5002")
                            (det-a 9 8 6)
                            (det-b 9 8 6)
                            (obj-color 8 8 6 "#ff792bb8")
                            (det-a 8 8 6)
                            (det-b 8 8 6)
                            (obj-color 8 1 6 "#ff4d0978")
                            (det-a 8 1 6)
                            (det-b 8 1 6)
                            (next-time-step 7 8)
                            (det-a 9 5 7)
                            (det-b 9 5 7)
                            (det-a 8 4 7)
                            (det-b 8 4 7)
                            (obj-color 7 8 7 "#ff3b5002")
                            (det-a 7 8 7)
                            (det-b 7 8 7)
                            (obj-color 6 8 7 "#ff792bb8")
                            (det-a 6 8 7)
                            (det-b 6 8 7)
                            (obj-color 9 2 7 "#ff4d0978")
                            (det-a 9 2 7)
                            (det-b 9 2 7)
                            (next-time-step 8 9)
                            (det-a 7 5 8)
                            (det-b 7 5 8)
                            (det-a 6 4 8)
                            (det-b 6 4 8)
                            (obj-color 5 8 8 "#ff3b5002")
                            (det-a 5 8 8)
                            (det-b 5 8 8)
                            (obj-color 4 8 8 "#ff792bb8")
                            (det-a 4 8 8)
                            (det-b 4 8 8)
                            (obj-color 7 0 8 "#ff4d0978")
                            (det-a 7 0 8)
                            (det-b 7 0 8)
                            (next-time-step 9 10)
                            (det-b 8 6 9)
                            (det-b 8 4 9)
                            (det-b 4 4 9)
                            (obj-color 3 8 9 "#ff3b5002")
                            (det-b 3 8 9)
                            (obj-color 8 1 9 "#ff4d0978")
                            (det-b 8 1 9)
                            (next-time-step 10 11)
                            (det-a 7 5 10)
                            (det-b 7 5 10)
                            (det-a 7 3 10)
                            (det-b 7 3 10)
                            (det-a 4 6 10)
                            (det-b 4 6 10)
                            (obj-color 5 8 10 "#ff3b5002")
                            (det-a 5 8 10)
                            (det-b 5 8 10)
                            (obj-color 7 0 10 "#ff4d0978")
                            (det-a 7 0 10)
                            (det-b 7 0 10)
                            )
                )))