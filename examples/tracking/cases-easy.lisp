(setq *cases* (list
(make-exp-case
:groundtruth '(
(mov 9 8 8 5 1 2 "#ffe1272a")
(mov 9 6 9 8 0 1 "#ffe1272a")
(mov 8 5 6 3 2 3 "#ffe1272a")
(mov 6 3 5 0 1 2 "#ff8ccdde")
(mov 5 0 5 2 2 3 "#ff8ccdde")
(mov 6 5 6 3 0 1 "#ff8ccdde")
)
:evidence '(
(next-time-step 0 1)
(obj-color 9 6 0 "#ffe1272a")
(det-a 9 6 0)
(obj-color 6 5 0 "#ff8ccdde")
(det-a 6 5 0)
(next-time-step 1 2)
(obj-color 9 8 1 "#ffe1272a")
(det-a 9 8 1)
(det-b 9 8 1)
(obj-color 6 3 1 "#ff8ccdde")
(det-a 6 3 1)
(det-b 6 3 1)
(next-time-step 2 3)
(obj-color 8 5 2 "#ffe1272a")
(det-b 8 5 2)
(obj-color 5 0 2 "#ff8ccdde")
(det-b 5 0 2)
(next-time-step 3 4)
(obj-color 6 3 3 "#ffe1272a")
(det-a 6 3 3)
(det-b 6 3 3)
(obj-color 5 2 3 "#ff8ccdde")
(det-a 5 2 3)
(det-b 5 2 3)
)
)
(make-exp-case
:groundtruth '(
(mov 8 7 8 9 0 1 "#ff02da4d")
(mov 2 7 1 6 1 2 "#ff003e72")
(mov 1 6 0 7 2 3 "#ff003e72")
(mov 8 9 6 7 1 2 "#ff02da4d")
(mov 6 7 5 8 2 3 "#ff02da4d")
(mov 3 8 2 7 0 1 "#ff003e72")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 7 0 "#ff02da4d")
(det-a 8 7 0)
(obj-color 3 8 0 "#ff003e72")
(det-a 3 8 0)
(next-time-step 1 2)
(obj-color 8 9 1 "#ff02da4d")
(det-a 8 9 1)
(det-b 8 9 1)
(obj-color 2 7 1 "#ff003e72")
(det-a 2 7 1)
(det-b 2 7 1)
(next-time-step 2 3)
(obj-color 6 7 2 "#ff02da4d")
(det-b 6 7 2)
(obj-color 1 6 2 "#ff003e72")
(det-b 1 6 2)
(next-time-step 3 4)
(obj-color 5 8 3 "#ff02da4d")
(det-a 5 8 3)
(det-b 5 8 3)
(obj-color 0 7 3 "#ff003e72")
(det-a 0 7 3)
(det-b 0 7 3)
)
)
(make-exp-case
:groundtruth '(
(mov 9 7 9 9 1 2 "#ffd4c410")
(mov 9 3 6 4 1 2 "#ff2923b4")
(mov 6 4 4 2 2 3 "#ff2923b4")
(mov 9 9 6 6 2 3 "#ffd4c410")
(mov 9 5 9 7 0 1 "#ffd4c410")
(mov 4 4 9 3 0 1 "#ff2923b4")
)
:evidence '(
(next-time-step 0 1)
(obj-color 9 5 0 "#ffd4c410")
(det-a 9 5 0)
(obj-color 4 4 0 "#ff2923b4")
(det-a 4 4 0)
(next-time-step 1 2)
(obj-color 9 7 1 "#ffd4c410")
(det-a 9 7 1)
(det-b 9 7 1)
(obj-color 9 3 1 "#ff2923b4")
(det-a 9 3 1)
(det-b 9 3 1)
(next-time-step 2 3)
(obj-color 9 9 2 "#ffd4c410")
(det-b 9 9 2)
(obj-color 6 4 2 "#ff2923b4")
(det-b 6 4 2)
(next-time-step 3 4)
(obj-color 6 6 3 "#ffd4c410")
(det-a 6 6 3)
(det-b 6 6 3)
(obj-color 4 2 3 "#ff2923b4")
(det-a 4 2 3)
(det-b 4 2 3)
)
)
(make-exp-case
:groundtruth '(
(mov 7 9 5 9 2 3 "#ffdd6467")
(mov 8 3 8 5 0 1 "#ffdf8bc4")
(mov 7 4 9 2 2 3 "#ffdf8bc4")
(mov 7 9 5 7 0 1 "#ffdd6467")
(mov 8 5 7 4 1 2 "#ffdf8bc4")
(mov 5 7 7 9 1 2 "#ffdd6467")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 3 0 "#ffdf8bc4")
(det-a 8 3 0)
(obj-color 7 9 0 "#ffdd6467")
(det-a 7 9 0)
(next-time-step 1 2)
(obj-color 8 5 1 "#ffdf8bc4")
(det-a 8 5 1)
(det-b 8 5 1)
(obj-color 5 7 1 "#ffdd6467")
(det-a 5 7 1)
(det-b 5 7 1)
(next-time-step 2 3)
(obj-color 7 9 2 "#ffdd6467")
(det-b 7 9 2)
(obj-color 7 4 2 "#ffdf8bc4")
(det-b 7 4 2)
(next-time-step 3 4)
(obj-color 9 2 3 "#ffdf8bc4")
(det-a 9 2 3)
(det-b 9 2 3)
(obj-color 5 9 3 "#ffdd6467")
(det-a 5 9 3)
(det-b 5 9 3)
)
)
(make-exp-case
:groundtruth '(
(mov 2 7 2 9 2 3 "#fffaeffc")
(mov 1 2 2 7 1 2 "#fffaeffc")
(mov 5 0 4 1 1 2 "#ff16ef67")
(mov 4 1 3 4 2 3 "#ff16ef67")
(mov 5 2 5 0 0 1 "#ff16ef67")
(mov 3 4 1 2 0 1 "#fffaeffc")
)
:evidence '(
(next-time-step 0 1)
(obj-color 5 2 0 "#ff16ef67")
(det-a 5 2 0)
(obj-color 3 4 0 "#fffaeffc")
(det-a 3 4 0)
(next-time-step 1 2)
(obj-color 5 0 1 "#ff16ef67")
(det-a 5 0 1)
(det-b 5 0 1)
(obj-color 1 2 1 "#fffaeffc")
(det-a 1 2 1)
(det-b 1 2 1)
(next-time-step 2 3)
(obj-color 4 1 2 "#ff16ef67")
(det-b 4 1 2)
(obj-color 2 7 2 "#fffaeffc")
(det-b 2 7 2)
(next-time-step 3 4)
(obj-color 3 4 3 "#ff16ef67")
(det-a 3 4 3)
(det-b 3 4 3)
(obj-color 2 9 3 "#fffaeffc")
(det-a 2 9 3)
(det-b 2 9 3)
)
)
(make-exp-case
:groundtruth '(
(mov 9 8 8 7 2 3 "#ff01690a")
(mov 7 6 9 8 1 2 "#ff01690a")
(mov 3 0 4 3 0 1 "#ffb55986")
(mov 4 3 3 4 1 2 "#ffb55986")
(mov 8 7 7 6 0 1 "#ff01690a")
(mov 3 4 3 2 2 3 "#ffb55986")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 7 0 "#ff01690a")
(det-a 8 7 0)
(obj-color 3 0 0 "#ffb55986")
(det-a 3 0 0)
(next-time-step 1 2)
(obj-color 7 6 1 "#ff01690a")
(det-a 7 6 1)
(det-b 7 6 1)
(obj-color 4 3 1 "#ffb55986")
(det-a 4 3 1)
(det-b 4 3 1)
(next-time-step 2 3)
(obj-color 9 8 2 "#ff01690a")
(det-b 9 8 2)
(obj-color 3 4 2 "#ffb55986")
(det-b 3 4 2)
(next-time-step 3 4)
(obj-color 8 7 3 "#ff01690a")
(det-a 8 7 3)
(det-b 8 7 3)
(obj-color 3 2 3 "#ffb55986")
(det-a 3 2 3)
(det-b 3 2 3)
)
)
(make-exp-case
:groundtruth '(
(mov 1 0 3 0 0 1 "#ff69e12b")
(mov 3 5 4 6 1 2 "#ff6887f8")
(mov 0 6 3 5 0 1 "#ff6887f8")
(mov 4 6 6 4 2 3 "#ff6887f8")
(mov 3 0 1 0 1 2 "#ff69e12b")
(mov 1 0 0 3 2 3 "#ff69e12b")
)
:evidence '(
(next-time-step 0 1)
(obj-color 1 0 0 "#ff69e12b")
(det-a 1 0 0)
(obj-color 0 6 0 "#ff6887f8")
(det-a 0 6 0)
(next-time-step 1 2)
(obj-color 3 5 1 "#ff6887f8")
(det-a 3 5 1)
(det-b 3 5 1)
(obj-color 3 0 1 "#ff69e12b")
(det-a 3 0 1)
(det-b 3 0 1)
(next-time-step 2 3)
(obj-color 4 6 2 "#ff6887f8")
(det-b 4 6 2)
(obj-color 1 0 2 "#ff69e12b")
(det-b 1 0 2)
(next-time-step 3 4)
(obj-color 6 4 3 "#ff6887f8")
(det-a 6 4 3)
(det-b 6 4 3)
(obj-color 0 3 3 "#ff69e12b")
(det-a 0 3 3)
(det-b 0 3 3)
)
)
(make-exp-case
:groundtruth '(
(mov 7 1 8 2 1 2 "#ff7572a6")
(mov 6 8 5 9 2 3 "#ff0faad8")
(mov 5 9 4 8 0 1 "#ff0faad8")
(mov 4 8 6 8 1 2 "#ff0faad8")
(mov 8 2 7 1 2 3 "#ff7572a6")
(mov 8 0 7 1 0 1 "#ff7572a6")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 0 0 "#ff7572a6")
(det-a 8 0 0)
(obj-color 5 9 0 "#ff0faad8")
(det-a 5 9 0)
(next-time-step 1 2)
(obj-color 7 1 1 "#ff7572a6")
(det-a 7 1 1)
(det-b 7 1 1)
(obj-color 4 8 1 "#ff0faad8")
(det-a 4 8 1)
(det-b 4 8 1)
(next-time-step 2 3)
(obj-color 8 2 2 "#ff7572a6")
(det-b 8 2 2)
(obj-color 6 8 2 "#ff0faad8")
(det-b 6 8 2)
(next-time-step 3 4)
(obj-color 7 1 3 "#ff7572a6")
(det-a 7 1 3)
(det-b 7 1 3)
(obj-color 5 9 3 "#ff0faad8")
(det-a 5 9 3)
(det-b 5 9 3)
)
)
(make-exp-case
:groundtruth '(
(mov 4 0 2 0 2 3 "#ff2fa9cb")
(mov 5 3 2 4 2 3 "#ff6f6464")
(mov 6 0 5 3 1 2 "#ff6f6464")
(mov 4 0 6 0 0 1 "#ff6f6464")
(mov 0 2 2 2 0 1 "#ff2fa9cb")
(mov 2 2 4 0 1 2 "#ff2fa9cb")
)
:evidence '(
(next-time-step 0 1)
(obj-color 4 0 0 "#ff6f6464")
(det-a 4 0 0)
(obj-color 0 2 0 "#ff2fa9cb")
(det-a 0 2 0)
(next-time-step 1 2)
(obj-color 6 0 1 "#ff6f6464")
(det-a 6 0 1)
(det-b 6 0 1)
(obj-color 2 2 1 "#ff2fa9cb")
(det-a 2 2 1)
(det-b 2 2 1)
(next-time-step 2 3)
(obj-color 5 3 2 "#ff6f6464")
(det-b 5 3 2)
(obj-color 4 0 2 "#ff2fa9cb")
(det-b 4 0 2)
(next-time-step 3 4)
(obj-color 2 4 3 "#ff6f6464")
(det-a 2 4 3)
(det-b 2 4 3)
(obj-color 2 0 3 "#ff2fa9cb")
(det-a 2 0 3)
(det-b 2 0 3)
)
)
(make-exp-case
:groundtruth '(
(mov 0 7 2 9 1 2 "#ff9e4597")
(mov 7 3 6 0 1 2 "#ffa536ad")
(mov 6 0 3 1 2 3 "#ffa536ad")
(mov 2 9 5 8 2 3 "#ff9e4597")
(mov 8 4 7 3 0 1 "#ffa536ad")
(mov 1 8 0 7 0 1 "#ff9e4597")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 4 0 "#ffa536ad")
(det-a 8 4 0)
(obj-color 1 8 0 "#ff9e4597")
(det-a 1 8 0)
(next-time-step 1 2)
(obj-color 7 3 1 "#ffa536ad")
(det-a 7 3 1)
(det-b 7 3 1)
(obj-color 0 7 1 "#ff9e4597")
(det-a 0 7 1)
(det-b 0 7 1)
(next-time-step 2 3)
(obj-color 6 0 2 "#ffa536ad")
(det-b 6 0 2)
(obj-color 2 9 2 "#ff9e4597")
(det-b 2 9 2)
(next-time-step 3 4)
(obj-color 5 8 3 "#ff9e4597")
(det-a 5 8 3)
(det-b 5 8 3)
(obj-color 3 1 3 "#ffa536ad")
(det-a 3 1 3)
(det-b 3 1 3)
)
)
(make-exp-case
:groundtruth '(
(mov 9 5 7 5 2 3 "#ff792bb8")
(mov 2 4 5 3 2 3 "#ff4aecb5")
(mov 5 5 9 5 1 2 "#ff792bb8")
(mov 6 6 5 5 0 1 "#ff792bb8")
(mov 0 2 2 4 1 2 "#ff4aecb5")
(mov 2 4 0 2 0 1 "#ff4aecb5")
)
:evidence '(
(next-time-step 0 1)
(obj-color 6 6 0 "#ff792bb8")
(det-a 6 6 0)
(obj-color 2 4 0 "#ff4aecb5")
(det-a 2 4 0)
(next-time-step 1 2)
(obj-color 5 5 1 "#ff792bb8")
(det-a 5 5 1)
(det-b 5 5 1)
(obj-color 0 2 1 "#ff4aecb5")
(det-a 0 2 1)
(det-b 0 2 1)
(next-time-step 2 3)
(obj-color 9 5 2 "#ff792bb8")
(det-b 9 5 2)
(obj-color 2 4 2 "#ff4aecb5")
(det-b 2 4 2)
(next-time-step 3 4)
(obj-color 7 5 3 "#ff792bb8")
(det-a 7 5 3)
(det-b 7 5 3)
(obj-color 5 3 3 "#ff4aecb5")
(det-a 5 3 3)
(det-b 5 3 3)
)
)
(make-exp-case
:groundtruth '(
(mov 8 8 7 9 0 1 "#ff8b84ee")
(mov 5 1 6 2 1 2 "#ff749e8b")
(mov 4 0 5 1 0 1 "#ff749e8b")
(mov 7 7 6 6 2 3 "#ff8b84ee")
(mov 7 9 7 7 1 2 "#ff8b84ee")
(mov 6 2 5 5 2 3 "#ff749e8b")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 8 0 "#ff8b84ee")
(det-a 8 8 0)
(obj-color 4 0 0 "#ff749e8b")
(det-a 4 0 0)
(next-time-step 1 2)
(obj-color 7 9 1 "#ff8b84ee")
(det-a 7 9 1)
(det-b 7 9 1)
(obj-color 5 1 1 "#ff749e8b")
(det-a 5 1 1)
(det-b 5 1 1)
(next-time-step 2 3)
(obj-color 7 7 2 "#ff8b84ee")
(det-b 7 7 2)
(obj-color 6 2 2 "#ff749e8b")
(det-b 6 2 2)
(next-time-step 3 4)
(obj-color 6 6 3 "#ff8b84ee")
(det-a 6 6 3)
(det-b 6 6 3)
(obj-color 5 5 3 "#ff749e8b")
(det-a 5 5 3)
(det-b 5 5 3)
)
)
(make-exp-case
:groundtruth '(
(mov 3 1 2 2 1 2 "#ffaf2d38")
(mov 7 1 9 1 2 3 "#ff1d4193")
(mov 2 2 4 0 2 3 "#ffaf2d38")
(mov 7 3 3 1 0 1 "#ffaf2d38")
(mov 2 2 4 0 0 1 "#ff1d4193")
(mov 4 0 7 1 1 2 "#ff1d4193")
)
:evidence '(
(next-time-step 0 1)
(obj-color 7 3 0 "#ffaf2d38")
(det-a 7 3 0)
(obj-color 2 2 0 "#ff1d4193")
(det-a 2 2 0)
(next-time-step 1 2)
(obj-color 4 0 1 "#ff1d4193")
(det-a 4 0 1)
(det-b 4 0 1)
(obj-color 3 1 1 "#ffaf2d38")
(det-a 3 1 1)
(det-b 3 1 1)
(next-time-step 2 3)
(obj-color 7 1 2 "#ff1d4193")
(det-b 7 1 2)
(obj-color 2 2 2 "#ffaf2d38")
(det-b 2 2 2)
(next-time-step 3 4)
(obj-color 9 1 3 "#ff1d4193")
(det-a 9 1 3)
(det-b 9 1 3)
(obj-color 4 0 3 "#ffaf2d38")
(det-a 4 0 3)
(det-b 4 0 3)
)
)
(make-exp-case
:groundtruth '(
(mov 7 1 9 3 0 1 "#ffd0c841")
(mov 3 3 2 2 0 1 "#ff9e516d")
(mov 1 3 2 2 2 3 "#ff9e516d")
(mov 7 1 6 0 2 3 "#ffd0c841")
(mov 9 3 7 1 1 2 "#ffd0c841")
(mov 2 2 1 3 1 2 "#ff9e516d")
)
:evidence '(
(next-time-step 0 1)
(obj-color 7 1 0 "#ffd0c841")
(det-a 7 1 0)
(obj-color 3 3 0 "#ff9e516d")
(det-a 3 3 0)
(next-time-step 1 2)
(obj-color 9 3 1 "#ffd0c841")
(det-a 9 3 1)
(det-b 9 3 1)
(obj-color 2 2 1 "#ff9e516d")
(det-a 2 2 1)
(det-b 2 2 1)
(next-time-step 2 3)
(obj-color 7 1 2 "#ffd0c841")
(det-b 7 1 2)
(obj-color 1 3 2 "#ff9e516d")
(det-b 1 3 2)
(next-time-step 3 4)
(obj-color 6 0 3 "#ffd0c841")
(det-a 6 0 3)
(det-b 6 0 3)
(obj-color 2 2 3 "#ff9e516d")
(det-a 2 2 3)
(det-b 2 2 3)
)
)
(make-exp-case
:groundtruth '(
(mov 9 2 9 6 1 2 "#ff7d90fd")
(mov 9 6 8 7 2 3 "#ff7d90fd")
(mov 4 0 5 1 1 2 "#ff942e01")
(mov 5 1 4 0 0 1 "#ff942e01")
(mov 8 3 9 2 0 1 "#ff7d90fd")
(mov 5 1 7 1 2 3 "#ff942e01")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 3 0 "#ff7d90fd")
(det-a 8 3 0)
(obj-color 5 1 0 "#ff942e01")
(det-a 5 1 0)
(next-time-step 1 2)
(obj-color 9 2 1 "#ff7d90fd")
(det-a 9 2 1)
(det-b 9 2 1)
(obj-color 4 0 1 "#ff942e01")
(det-a 4 0 1)
(det-b 4 0 1)
(next-time-step 2 3)
(obj-color 9 6 2 "#ff7d90fd")
(det-b 9 6 2)
(obj-color 5 1 2 "#ff942e01")
(det-b 5 1 2)
(next-time-step 3 4)
(obj-color 8 7 3 "#ff7d90fd")
(det-a 8 7 3)
(det-b 8 7 3)
(obj-color 7 1 3 "#ff942e01")
(det-a 7 1 3)
(det-b 7 1 3)
)
)
(make-exp-case
:groundtruth '(
(mov 0 2 1 1 1 2 "#ff90123d")
(mov 6 1 4 3 1 2 "#ff3dcf39")
(mov 0 0 0 2 0 1 "#ff90123d")
(mov 6 3 6 1 0 1 "#ff3dcf39")
(mov 1 1 2 0 2 3 "#ff90123d")
(mov 4 3 7 2 2 3 "#ff3dcf39")
)
:evidence '(
(next-time-step 0 1)
(obj-color 6 3 0 "#ff3dcf39")
(det-a 6 3 0)
(obj-color 0 0 0 "#ff90123d")
(det-a 0 0 0)
(next-time-step 1 2)
(obj-color 6 1 1 "#ff3dcf39")
(det-a 6 1 1)
(det-b 6 1 1)
(obj-color 0 2 1 "#ff90123d")
(det-a 0 2 1)
(det-b 0 2 1)
(next-time-step 2 3)
(obj-color 4 3 2 "#ff3dcf39")
(det-b 4 3 2)
(obj-color 1 1 2 "#ff90123d")
(det-b 1 1 2)
(next-time-step 3 4)
(obj-color 7 2 3 "#ff3dcf39")
(det-a 7 2 3)
(det-b 7 2 3)
(obj-color 2 0 3 "#ff90123d")
(det-a 2 0 3)
(det-b 2 0 3)
)
)
(make-exp-case
:groundtruth '(
(mov 9 9 7 9 1 2 "#ffd5f06e")
(mov 9 7 9 9 0 1 "#ffd5f06e")
(mov 2 6 1 7 1 2 "#ffbda1b7")
(mov 1 7 1 5 2 3 "#ffbda1b7")
(mov 7 9 4 8 2 3 "#ffd5f06e")
(mov 1 5 2 6 0 1 "#ffbda1b7")
)
:evidence '(
(next-time-step 0 1)
(obj-color 9 7 0 "#ffd5f06e")
(det-a 9 7 0)
(obj-color 1 5 0 "#ffbda1b7")
(det-a 1 5 0)
(next-time-step 1 2)
(obj-color 9 9 1 "#ffd5f06e")
(det-a 9 9 1)
(det-b 9 9 1)
(obj-color 2 6 1 "#ffbda1b7")
(det-a 2 6 1)
(det-b 2 6 1)
(next-time-step 2 3)
(obj-color 7 9 2 "#ffd5f06e")
(det-b 7 9 2)
(obj-color 1 7 2 "#ffbda1b7")
(det-b 1 7 2)
(next-time-step 3 4)
(obj-color 4 8 3 "#ffd5f06e")
(det-a 4 8 3)
(det-b 4 8 3)
(obj-color 1 5 3 "#ffbda1b7")
(det-a 1 5 3)
(det-b 1 5 3)
)
)
(make-exp-case
:groundtruth '(
(mov 0 2 1 3 0 1 "#ff492722")
(mov 1 3 1 1 1 2 "#ff492722")
(mov 2 3 1 6 0 1 "#ffd45465")
(mov 1 1 0 2 2 3 "#ff492722")
(mov 1 6 2 7 1 2 "#ffd45465")
(mov 2 7 1 6 2 3 "#ffd45465")
)
:evidence '(
(next-time-step 0 1)
(obj-color 2 3 0 "#ffd45465")
(det-a 2 3 0)
(obj-color 0 2 0 "#ff492722")
(det-a 0 2 0)
(next-time-step 1 2)
(obj-color 1 6 1 "#ffd45465")
(det-a 1 6 1)
(det-b 1 6 1)
(obj-color 1 3 1 "#ff492722")
(det-a 1 3 1)
(det-b 1 3 1)
(next-time-step 2 3)
(obj-color 2 7 2 "#ffd45465")
(det-b 2 7 2)
(obj-color 1 1 2 "#ff492722")
(det-b 1 1 2)
(next-time-step 3 4)
(obj-color 1 6 3 "#ffd45465")
(det-a 1 6 3)
(det-b 1 6 3)
(obj-color 0 2 3 "#ff492722")
(det-a 0 2 3)
(det-b 0 2 3)
)
)
(make-exp-case
:groundtruth '(
(mov 3 5 6 4 1 2 "#ff1b34d4")
(mov 3 6 2 5 2 3 "#ffbbe9e1")
(mov 6 4 7 5 2 3 "#ff1b34d4")
(mov 4 5 3 6 1 2 "#ffbbe9e1")
(mov 6 5 4 5 0 1 "#ffbbe9e1")
(mov 3 7 3 5 0 1 "#ff1b34d4")
)
:evidence '(
(next-time-step 0 1)
(obj-color 6 5 0 "#ffbbe9e1")
(det-a 6 5 0)
(obj-color 3 7 0 "#ff1b34d4")
(det-a 3 7 0)
(next-time-step 1 2)
(obj-color 4 5 1 "#ffbbe9e1")
(det-a 4 5 1)
(det-b 4 5 1)
(obj-color 3 5 1 "#ff1b34d4")
(det-a 3 5 1)
(det-b 3 5 1)
(next-time-step 2 3)
(obj-color 6 4 2 "#ff1b34d4")
(det-b 6 4 2)
(obj-color 3 6 2 "#ffbbe9e1")
(det-b 3 6 2)
(next-time-step 3 4)
(obj-color 7 5 3 "#ff1b34d4")
(det-a 7 5 3)
(det-b 7 5 3)
(obj-color 2 5 3 "#ffbbe9e1")
(det-a 2 5 3)
(det-b 2 5 3)
)
)
(make-exp-case
:groundtruth '(
(mov 6 0 5 1 1 2 "#fff39b75")
(mov 5 1 4 2 2 3 "#fff39b75")
(mov 4 3 3 0 0 1 "#ff98c2f4")
(mov 9 1 6 0 0 1 "#fff39b75")
(mov 3 0 1 0 1 2 "#ff98c2f4")
(mov 1 0 0 1 2 3 "#ff98c2f4")
)
:evidence '(
(next-time-step 0 1)
(obj-color 9 1 0 "#fff39b75")
(det-a 9 1 0)
(obj-color 4 3 0 "#ff98c2f4")
(det-a 4 3 0)
(next-time-step 1 2)
(obj-color 6 0 1 "#fff39b75")
(det-a 6 0 1)
(det-b 6 0 1)
(obj-color 3 0 1 "#ff98c2f4")
(det-a 3 0 1)
(det-b 3 0 1)
(next-time-step 2 3)
(obj-color 5 1 2 "#fff39b75")
(det-b 5 1 2)
(obj-color 1 0 2 "#ff98c2f4")
(det-b 1 0 2)
(next-time-step 3 4)
(obj-color 4 2 3 "#fff39b75")
(det-a 4 2 3)
(det-b 4 2 3)
(obj-color 0 1 3 "#ff98c2f4")
(det-a 0 1 3)
(det-b 0 1 3)
)
)
(make-exp-case
:groundtruth '(
(mov 5 3 6 6 0 1 "#ff76c8ae")
(mov 3 7 2 4 0 1 "#ff5327c5")
(mov 2 4 0 2 1 2 "#ff5327c5")
(mov 0 2 1 1 2 3 "#ff5327c5")
(mov 6 8 5 5 2 3 "#ff76c8ae")
(mov 6 6 6 8 1 2 "#ff76c8ae")
)
:evidence '(
(next-time-step 0 1)
(obj-color 5 3 0 "#ff76c8ae")
(det-a 5 3 0)
(obj-color 3 7 0 "#ff5327c5")
(det-a 3 7 0)
(next-time-step 1 2)
(obj-color 6 6 1 "#ff76c8ae")
(det-a 6 6 1)
(det-b 6 6 1)
(obj-color 2 4 1 "#ff5327c5")
(det-a 2 4 1)
(det-b 2 4 1)
(next-time-step 2 3)
(obj-color 6 8 2 "#ff76c8ae")
(det-b 6 8 2)
(obj-color 0 2 2 "#ff5327c5")
(det-b 0 2 2)
(next-time-step 3 4)
(obj-color 5 5 3 "#ff76c8ae")
(det-a 5 5 3)
(det-b 5 5 3)
(obj-color 1 1 3 "#ff5327c5")
(det-a 1 1 3)
(det-b 1 1 3)
)
)
(make-exp-case
:groundtruth '(
(mov 9 2 8 3 1 2 "#fff35ac0")
(mov 8 3 8 5 2 3 "#fff35ac0")
(mov 8 3 9 2 0 1 "#fff35ac0")
(mov 5 0 6 3 1 2 "#ffab2a6d")
(mov 6 3 7 2 2 3 "#ffab2a6d")
(mov 4 5 5 0 0 1 "#ffab2a6d")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 3 0 "#fff35ac0")
(det-a 8 3 0)
(obj-color 4 5 0 "#ffab2a6d")
(det-a 4 5 0)
(next-time-step 1 2)
(obj-color 9 2 1 "#fff35ac0")
(det-a 9 2 1)
(det-b 9 2 1)
(obj-color 5 0 1 "#ffab2a6d")
(det-a 5 0 1)
(det-b 5 0 1)
(next-time-step 2 3)
(obj-color 8 3 2 "#fff35ac0")
(det-b 8 3 2)
(obj-color 6 3 2 "#ffab2a6d")
(det-b 6 3 2)
(next-time-step 3 4)
(obj-color 8 5 3 "#fff35ac0")
(det-a 8 5 3)
(det-b 8 5 3)
(obj-color 7 2 3 "#ffab2a6d")
(det-a 7 2 3)
(det-b 7 2 3)
)
)
(make-exp-case
:groundtruth '(
(mov 1 7 2 6 1 2 "#ffe95ba6")
(mov 2 6 3 7 2 3 "#ffe95ba6")
(mov 8 0 5 3 2 3 "#ff5cb0ae")
(mov 1 9 1 7 0 1 "#ffe95ba6")
(mov 8 2 7 1 0 1 "#ff5cb0ae")
(mov 7 1 8 0 1 2 "#ff5cb0ae")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 2 0 "#ff5cb0ae")
(det-a 8 2 0)
(obj-color 1 9 0 "#ffe95ba6")
(det-a 1 9 0)
(next-time-step 1 2)
(obj-color 7 1 1 "#ff5cb0ae")
(det-a 7 1 1)
(det-b 7 1 1)
(obj-color 1 7 1 "#ffe95ba6")
(det-a 1 7 1)
(det-b 1 7 1)
(next-time-step 2 3)
(obj-color 8 0 2 "#ff5cb0ae")
(det-b 8 0 2)
(obj-color 2 6 2 "#ffe95ba6")
(det-b 2 6 2)
(next-time-step 3 4)
(obj-color 5 3 3 "#ff5cb0ae")
(det-a 5 3 3)
(det-b 5 3 3)
(obj-color 3 7 3 "#ffe95ba6")
(det-a 3 7 3)
(det-b 3 7 3)
)
)
(make-exp-case
:groundtruth '(
(mov 2 2 3 1 1 2 "#ff4e0459")
(mov 7 3 4 4 2 3 "#ff44e585")
(mov 3 1 1 1 2 3 "#ff4e0459")
(mov 7 1 7 3 1 2 "#ff44e585")
(mov 4 0 2 2 0 1 "#ff4e0459")
(mov 4 2 7 1 0 1 "#ff44e585")
)
:evidence '(
(next-time-step 0 1)
(obj-color 4 2 0 "#ff44e585")
(det-a 4 2 0)
(obj-color 4 0 0 "#ff4e0459")
(det-a 4 0 0)
(next-time-step 1 2)
(obj-color 7 1 1 "#ff44e585")
(det-a 7 1 1)
(det-b 7 1 1)
(obj-color 2 2 1 "#ff4e0459")
(det-a 2 2 1)
(det-b 2 2 1)
(next-time-step 2 3)
(obj-color 7 3 2 "#ff44e585")
(det-b 7 3 2)
(obj-color 3 1 2 "#ff4e0459")
(det-b 3 1 2)
(next-time-step 3 4)
(obj-color 4 4 3 "#ff44e585")
(det-a 4 4 3)
(det-b 4 4 3)
(obj-color 1 1 3 "#ff4e0459")
(det-a 1 1 3)
(det-b 1 1 3)
)
)
(make-exp-case
:groundtruth '(
(mov 8 2 7 1 2 3 "#ff1e19fd")
(mov 8 8 7 7 1 2 "#ff53b292")
(mov 8 0 8 2 1 2 "#ff1e19fd")
(mov 8 2 8 0 0 1 "#ff1e19fd")
(mov 7 7 5 7 2 3 "#ff53b292")
(mov 7 7 8 8 0 1 "#ff53b292")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 2 0 "#ff1e19fd")
(det-a 8 2 0)
(obj-color 7 7 0 "#ff53b292")
(det-a 7 7 0)
(next-time-step 1 2)
(obj-color 8 8 1 "#ff53b292")
(det-a 8 8 1)
(det-b 8 8 1)
(obj-color 8 0 1 "#ff1e19fd")
(det-a 8 0 1)
(det-b 8 0 1)
(next-time-step 2 3)
(obj-color 8 2 2 "#ff1e19fd")
(det-b 8 2 2)
(obj-color 7 7 2 "#ff53b292")
(det-b 7 7 2)
(next-time-step 3 4)
(obj-color 7 1 3 "#ff1e19fd")
(det-a 7 1 3)
(det-b 7 1 3)
(obj-color 5 7 3 "#ff53b292")
(det-a 5 7 3)
(det-b 5 7 3)
)
)
(make-exp-case
:groundtruth '(
(mov 6 6 5 3 2 3 "#ff9a1eb5")
(mov 9 7 9 9 0 1 "#ff9a1eb5")
(mov 9 9 6 6 1 2 "#ff9a1eb5")
(mov 3 9 1 5 2 3 "#ff26ac18")
(mov 1 9 3 7 0 1 "#ff26ac18")
(mov 3 7 3 9 1 2 "#ff26ac18")
)
:evidence '(
(next-time-step 0 1)
(obj-color 9 7 0 "#ff9a1eb5")
(det-a 9 7 0)
(obj-color 1 9 0 "#ff26ac18")
(det-a 1 9 0)
(next-time-step 1 2)
(obj-color 9 9 1 "#ff9a1eb5")
(det-a 9 9 1)
(det-b 9 9 1)
(obj-color 3 7 1 "#ff26ac18")
(det-a 3 7 1)
(det-b 3 7 1)
(next-time-step 2 3)
(obj-color 6 6 2 "#ff9a1eb5")
(det-b 6 6 2)
(obj-color 3 9 2 "#ff26ac18")
(det-b 3 9 2)
(next-time-step 3 4)
(obj-color 5 3 3 "#ff9a1eb5")
(det-a 5 3 3)
(det-b 5 3 3)
(obj-color 1 5 3 "#ff26ac18")
(det-a 1 5 3)
(det-b 1 5 3)
)
)
(make-exp-case
:groundtruth '(
(mov 7 8 5 4 2 3 "#ff6a2a12")
(mov 8 7 7 8 1 2 "#ff6a2a12")
(mov 9 6 8 7 0 1 "#ff6a2a12")
(mov 2 3 4 5 0 1 "#ff9b5692")
(mov 1 4 0 7 2 3 "#ff9b5692")
(mov 4 5 1 4 1 2 "#ff9b5692")
)
:evidence '(
(next-time-step 0 1)
(obj-color 9 6 0 "#ff6a2a12")
(det-a 9 6 0)
(obj-color 2 3 0 "#ff9b5692")
(det-a 2 3 0)
(next-time-step 1 2)
(obj-color 8 7 1 "#ff6a2a12")
(det-a 8 7 1)
(det-b 8 7 1)
(obj-color 4 5 1 "#ff9b5692")
(det-a 4 5 1)
(det-b 4 5 1)
(next-time-step 2 3)
(obj-color 7 8 2 "#ff6a2a12")
(det-b 7 8 2)
(obj-color 1 4 2 "#ff9b5692")
(det-b 1 4 2)
(next-time-step 3 4)
(obj-color 5 4 3 "#ff6a2a12")
(det-a 5 4 3)
(det-b 5 4 3)
(obj-color 0 7 3 "#ff9b5692")
(det-a 0 7 3)
(det-b 0 7 3)
)
)
(make-exp-case
:groundtruth '(
(mov 1 4 1 6 0 1 "#ffed1d8c")
(mov 5 4 8 5 0 1 "#ffac7f38")
(mov 8 5 9 4 1 2 "#ffac7f38")
(mov 0 7 1 8 2 3 "#ffed1d8c")
(mov 9 4 9 0 2 3 "#ffac7f38")
(mov 1 6 0 7 1 2 "#ffed1d8c")
)
:evidence '(
(next-time-step 0 1)
(obj-color 5 4 0 "#ffac7f38")
(det-a 5 4 0)
(obj-color 1 4 0 "#ffed1d8c")
(det-a 1 4 0)
(next-time-step 1 2)
(obj-color 8 5 1 "#ffac7f38")
(det-a 8 5 1)
(det-b 8 5 1)
(obj-color 1 6 1 "#ffed1d8c")
(det-a 1 6 1)
(det-b 1 6 1)
(next-time-step 2 3)
(obj-color 9 4 2 "#ffac7f38")
(det-b 9 4 2)
(obj-color 0 7 2 "#ffed1d8c")
(det-b 0 7 2)
(next-time-step 3 4)
(obj-color 9 0 3 "#ffac7f38")
(det-a 9 0 3)
(det-b 9 0 3)
(obj-color 1 8 3 "#ffed1d8c")
(det-a 1 8 3)
(det-b 1 8 3)
)
)
(make-exp-case
:groundtruth '(
(mov 3 0 1 2 2 3 "#ffdecd22")
(mov 2 8 5 9 0 1 "#ff1c5ef8")
(mov 5 9 0 8 1 2 "#ff1c5ef8")
(mov 5 2 3 0 1 2 "#ffdecd22")
(mov 8 1 5 2 0 1 "#ffdecd22")
(mov 0 8 2 6 2 3 "#ff1c5ef8")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 1 0 "#ffdecd22")
(det-a 8 1 0)
(obj-color 2 8 0 "#ff1c5ef8")
(det-a 2 8 0)
(next-time-step 1 2)
(obj-color 5 9 1 "#ff1c5ef8")
(det-a 5 9 1)
(det-b 5 9 1)
(obj-color 5 2 1 "#ffdecd22")
(det-a 5 2 1)
(det-b 5 2 1)
(next-time-step 2 3)
(obj-color 3 0 2 "#ffdecd22")
(det-b 3 0 2)
(obj-color 0 8 2 "#ff1c5ef8")
(det-b 0 8 2)
(next-time-step 3 4)
(obj-color 2 6 3 "#ff1c5ef8")
(det-a 2 6 3)
(det-b 2 6 3)
(obj-color 1 2 3 "#ffdecd22")
(det-a 1 2 3)
(det-b 1 2 3)
)
)
(make-exp-case
:groundtruth '(
(mov 0 8 1 7 1 2 "#ff287488")
(mov 1 7 4 6 2 3 "#ff287488")
(mov 7 8 5 8 1 2 "#ff252b1e")
(mov 5 8 7 8 2 3 "#ff252b1e")
(mov 1 9 0 8 0 1 "#ff287488")
(mov 8 9 7 8 0 1 "#ff252b1e")
)
:evidence '(
(next-time-step 0 1)
(obj-color 8 9 0 "#ff252b1e")
(det-a 8 9 0)
(obj-color 1 9 0 "#ff287488")
(det-a 1 9 0)
(next-time-step 1 2)
(obj-color 7 8 1 "#ff252b1e")
(det-a 7 8 1)
(det-b 7 8 1)
(obj-color 0 8 1 "#ff287488")
(det-a 0 8 1)
(det-b 0 8 1)
(next-time-step 2 3)
(obj-color 5 8 2 "#ff252b1e")
(det-b 5 8 2)
(obj-color 1 7 2 "#ff287488")
(det-b 1 7 2)
(next-time-step 3 4)
(obj-color 7 8 3 "#ff252b1e")
(det-a 7 8 3)
(det-b 7 8 3)
(obj-color 4 6 3 "#ff287488")
(det-a 4 6 3)
(det-b 4 6 3)
)
)
))
