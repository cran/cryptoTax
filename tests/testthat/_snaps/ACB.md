# Example #0 - ACB

    Code
      ACB(data_adjustedcostbase1, spot.rate = "price", sup.loss = FALSE)
    Output
              date transaction quantity price fees total.price total.quantity  ACB
      1 2014-03-03         buy      100    50   10        5000            100 5010
      2 2014-05-01        sell       50   120   10        6000             50 2505
      3 2014-07-18         buy       50   130   10        6500            100 9015
      4 2014-09-25        sell       40    90   10        3600             60 5409
        ACB.share gains
      1     50.10    NA
      2     50.10  3485
      3     90.15    NA
      4     90.15   -16

# Example #1 - ACB

    Code
      ACB(data_adjustedcostbase2, spot.rate = "price", sup.loss = FALSE)
    Output
              date transaction quantity price total.price fees total.quantity  ACB
      1 2014-01-06         buy      100    50        5000    0            100 5000
      2 2014-11-03        sell      100    30        3000    0              0    0
      3 2014-11-04         buy      100    30        3000    0            100 3000
      4 2015-12-02        sell      100    80        8000    0              0    0
        ACB.share gains
      1        50    NA
      2         0 -2000
      3        30    NA
      4         0  5000

---

    Code
      ACB(data_adjustedcostbase2, spot.rate = "price")
    Output
              date transaction quantity price total.price fees total.quantity
      1 2014-01-06         buy      100    50        5000    0            100
      2 2014-11-03        sell      100    30        3000    0              0
      3 2014-11-04         buy      100    30        3000    0            100
      4 2015-12-02        sell      100    80        8000    0              0
                         suploss.range quantity.60days share.left60 sup.loss.quantity
      1 2013-12-07 UTC--2014-02-05 UTC             100          100                 0
      2 2014-10-04 UTC--2014-12-03 UTC             100          100               100
      3 2014-10-05 UTC--2014-12-04 UTC             100          100                 0
      4 2015-11-02 UTC--2016-01-01 UTC               0            0                 0
        sup.loss gains.uncorrected gains.sup gains.excess gains  ACB ACB.share
      1    FALSE                 0        NA           NA    NA 5000        50
      2     TRUE             -2000     -2000           NA    NA    0         0
      3    FALSE                 0        NA           NA    NA 5000        50
      4    FALSE              3000        NA           NA  3000    0         0

# Example #2 - ACB

    Code
      ACB(data_adjustedcostbase3, spot.rate = "price", sup.loss = FALSE)
    Output
              date transaction quantity price total.price fees total.quantity  ACB
      1 2014-01-06         buy      100    50        5000    0            100 5000
      2 2014-11-03         buy      100    30        3000    0            200 8000
      3 2014-11-04        sell      100    30        3000    0            100 4000
      4 2015-12-02        sell      100    80        8000    0              0    0
        ACB.share gains
      1        50    NA
      2        40    NA
      3        40 -1000
      4         0  4000

---

    Code
      ACB(data_adjustedcostbase3, spot.rate = "price")
    Output
              date transaction quantity price total.price fees total.quantity
      1 2014-01-06         buy      100    50        5000    0            100
      2 2014-11-03         buy      100    30        3000    0            200
      3 2014-11-04        sell      100    30        3000    0            100
      4 2015-12-02        sell      100    80        8000    0              0
                         suploss.range quantity.60days share.left60 sup.loss.quantity
      1 2013-12-07 UTC--2014-02-05 UTC             100          100                 0
      2 2014-10-04 UTC--2014-12-03 UTC             100          100                 0
      3 2014-10-05 UTC--2014-12-04 UTC             100          100               100
      4 2015-11-02 UTC--2016-01-01 UTC               0            0                 0
        sup.loss gains.uncorrected gains.sup gains.excess gains  ACB ACB.share
      1    FALSE                 0        NA           NA    NA 5000        50
      2    FALSE                 0        NA           NA    NA 8000        40
      3     TRUE             -1000     -1000           NA    NA 5000        50
      4    FALSE              3000        NA           NA  3000    0         0

# Example #3 - ACB

    Code
      ACB(data_adjustedcostbase4, spot.rate = "price", sup.loss = FALSE)
    Output
              date transaction quantity price total.price fees total.quantity ACB
      1 2015-01-02         buy      100   3.0         300    0            100 300
      2 2015-04-09        sell      100   2.0         200    0              0   0
      3 2015-04-10         buy       25   2.2          55    0             25  55
        ACB.share gains
      1       3.0    NA
      2       0.0  -100
      3       2.2    NA

---

    Code
      ACB(data_adjustedcostbase4, spot.rate = "price")
    Output
              date transaction quantity price total.price fees total.quantity
      1 2015-01-02         buy      100   3.0         300    0            100
      2 2015-04-09        sell      100   2.0         200    0              0
      3 2015-04-10         buy       25   2.2          55    0             25
                         suploss.range quantity.60days share.left60 sup.loss.quantity
      1 2014-12-03 UTC--2015-02-01 UTC             100          100                 0
      2 2015-03-10 UTC--2015-05-09 UTC              25           25               100
      3 2015-03-11 UTC--2015-05-10 UTC              25           25                 0
        sup.loss gains.uncorrected gains.sup gains.excess gains ACB ACB.share
      1    FALSE                 0        NA           NA    NA 300       3.0
      2     TRUE              -100       -25          -75   -75   0       0.0
      3    FALSE                 0        NA           NA    NA  80       3.2

# Example #4 - ACB

    Code
      ACB(data_adjustedcostbase5, spot.rate = "price", sup.loss = FALSE)
    Output
              date transaction quantity price total.price fees total.quantity ACB
      1 2015-04-09         buy      100     3         300    0            100 300
      2 2015-04-10        sell       80     2         160    0             20  60
        ACB.share gains
      1         3    NA
      2         3   -80

---

    Code
      ACB(data_adjustedcostbase5, spot.rate = "price")
    Output
              date transaction quantity price total.price fees total.quantity
      1 2015-04-09         buy      100     3         300    0            100
      2 2015-04-10        sell       80     2         160    0             20
                         suploss.range quantity.60days share.left60 sup.loss.quantity
      1 2015-03-10 UTC--2015-05-09 UTC             100           20                 0
      2 2015-03-11 UTC--2015-05-10 UTC             100           20                80
        sup.loss gains.uncorrected gains.sup gains.excess gains ACB ACB.share
      1    FALSE                 0        NA           NA    NA 300         3
      2     TRUE               -80       -20           NA    NA  80         4

# Example #5 - ACB

    Code
      ACB(data_adjustedcostbase6, spot.rate = "price", sup.loss = FALSE)
    Output
              date transaction quantity price total.price fees total.quantity ACB
      1 2015-04-09         buy      150     3         450    0            150 450
      2 2015-04-10        sell       20     2          40    0            130 390
      3 2015-04-15         buy       50     3         150    0            180 540
      4 2015-04-20        sell       10     2          20    0            170 510
      5 2015-05-15        sell       80     2         160    0             90 270
        ACB.share gains
      1         3    NA
      2         3   -20
      3         3    NA
      4         3   -10
      5         3   -80

---

    Code
      ACB(data_adjustedcostbase6, spot.rate = "price")
    Output
              date transaction quantity price total.price fees total.quantity
      1 2015-04-09         buy      150     3         450    0            150
      2 2015-04-10        sell       20     2          40    0            130
      3 2015-04-15         buy       50     3         150    0            180
      4 2015-04-20        sell       10     2          20    0            170
      5 2015-05-15        sell       80     2         160    0             90
                         suploss.range quantity.60days share.left60 sup.loss.quantity
      1 2015-03-10 UTC--2015-05-09 UTC             200          170                 0
      2 2015-03-11 UTC--2015-05-10 UTC             200          170                20
      3 2015-03-16 UTC--2015-05-15 UTC             200           90                 0
      4 2015-03-21 UTC--2015-05-20 UTC             200           90                10
      5 2015-04-15 UTC--2015-06-14 UTC              50           90                80
        sup.loss gains.uncorrected gains.sup gains.excess     gains      ACB
      1    FALSE           0.00000        NA           NA        NA 450.0000
      2     TRUE         -20.00000 -20.00000           NA        NA 410.0000
      3    FALSE           0.00000        NA           NA        NA 580.0000
      4     TRUE         -12.22222 -12.22222           NA        NA 560.0000
      5     TRUE        -103.52941 -64.70588    -38.82353 -38.82353 361.1765
        ACB.share
      1  3.000000
      2  3.153846
      3  3.222222
      4  3.294118
      5  4.013072

# Example #6 - CryptoTaxCalculator

    Code
      ACB(data_cryptotaxcalculator1, transaction = "trade", spot.rate = "price",
        sup.loss = FALSE)
    Output
              date trade currency price quantity total.price fees total.quantity
      1 2020-01-01   buy      BTC  5000        2       10000    0              2
      2 2020-02-03  sell      BTC  3000        2        6000    0              0
      3 2020-02-04   buy      BTC  3000        2        6000    0              2
      4 2021-02-04  sell      BTC 10000        2       20000    0              0
          ACB ACB.share gains
      1 10000      5000    NA
      2     0         0 -4000
      3  6000      3000    NA
      4     0         0 14000

---

    Code
      ACB(data_cryptotaxcalculator1, transaction = "trade", spot.rate = "price")
    Output
              date trade currency price quantity total.price fees total.quantity
      1 2020-01-01   buy      BTC  5000        2       10000    0              2
      2 2020-02-03  sell      BTC  3000        2        6000    0              0
      3 2020-02-04   buy      BTC  3000        2        6000    0              2
      4 2021-02-04  sell      BTC 10000        2       20000    0              0
                         suploss.range quantity.60days share.left60 sup.loss.quantity
      1 2019-12-02 UTC--2020-01-31 UTC               2            2                 0
      2 2020-01-04 UTC--2020-03-04 UTC               2            2                 2
      3 2020-01-05 UTC--2020-03-05 UTC               2            2                 0
      4 2021-01-05 UTC--2021-03-06 UTC               0            0                 0
        sup.loss gains.uncorrected gains.sup gains.excess gains   ACB ACB.share
      1    FALSE                 0        NA           NA    NA 10000      5000
      2     TRUE             -4000     -4000           NA    NA     0         0
      3    FALSE                 0        NA           NA    NA 10000      5000
      4    FALSE             10000        NA           NA 10000     0         0

# Example #7 - CryptoTaxCalculator

    Code
      ACB(data_cryptotaxcalculator2, transaction = "trade", spot.rate = "price",
        sup.loss = FALSE)
    Output
              date trade currency price quantity total.price fees total.quantity
      1 2020-01-01   buy      BTC  5000        2       10000    0              2
      2 2020-02-05   buy      BTC  1000        2        2000    0              4
      3 2020-02-06  sell      BTC  1000        2        2000    0              2
      4 2021-02-06  sell      BTC 10000        2       20000    0              0
          ACB ACB.share gains
      1 10000      5000    NA
      2 12000      3000    NA
      3  6000      3000 -4000
      4     0         0 14000

---

    Code
      ACB(data_cryptotaxcalculator2, transaction = "trade", spot.rate = "price")
    Output
              date trade currency price quantity total.price fees total.quantity
      1 2020-01-01   buy      BTC  5000        2       10000    0              2
      2 2020-02-05   buy      BTC  1000        2        2000    0              4
      3 2020-02-06  sell      BTC  1000        2        2000    0              2
      4 2021-02-06  sell      BTC 10000        2       20000    0              0
                         suploss.range quantity.60days share.left60 sup.loss.quantity
      1 2019-12-02 UTC--2020-01-31 UTC               2            2                 0
      2 2020-01-06 UTC--2020-03-06 UTC               2            2                 0
      3 2020-01-07 UTC--2020-03-07 UTC               2            2                 2
      4 2021-01-07 UTC--2021-03-08 UTC               0            0                 0
        sup.loss gains.uncorrected gains.sup gains.excess gains   ACB ACB.share
      1    FALSE                 0        NA           NA    NA 10000      5000
      2    FALSE                 0        NA           NA    NA 12000      3000
      3     TRUE             -4000     -4000           NA    NA 10000      5000
      4    FALSE             10000        NA           NA 10000     0         0

# Example #8 - Coinpanda

    Code
      ACB(data_coinpanda1, transaction = "type", quantity = "amount", total.price = "price",
        sup.loss = FALSE)
    Output
        type       date currency amount price fees total.quantity  ACB ACB.share
      1  buy 2019-08-14      BTC    0.2  1800   20            0.2 1820  9100.000
      2  buy 2019-10-29      BTC    0.6  4300   20            0.8 6140  7675.000
      3 sell 2020-06-05      BTC    0.8  5700    0            0.0    0     0.000
      4  buy 2020-09-23      BTC    1.2  8200    0            1.2 8200  6833.333
        gains
      1    NA
      2    NA
      3  -440
      4    NA

# Example #9 - Coinpanda

    Code
      ACB(data_coinpanda2, transaction = "type", quantity = "amount", total.price = "price",
        sup.loss = FALSE)
    Output
        type       date currency amount price fees total.quantity  ACB ACB.share
      1  buy 2019-08-14      BTC    0.2  1800   20            0.2 1820  9100.000
      2  buy 2019-10-29      BTC    0.6  4300   20            0.8 6140  7675.000
      3 sell 2020-06-05      BTC    0.8  5700    0            0.0    0     0.000
      4  buy 2020-06-07      BTC    1.2  7000    0            1.2 7000  5833.333
        gains
      1    NA
      2    NA
      3  -440
      4    NA

---

    Code
      ACB(data_coinpanda2, transaction = "type", quantity = "amount", total.price = "price")
    Output
        type       date currency amount price fees total.quantity
      1  buy 2019-08-14      BTC    0.2  1800   20            0.2
      2  buy 2019-10-29      BTC    0.6  4300   20            0.8
      3 sell 2020-06-05      BTC    0.8  5700    0            0.0
      4  buy 2020-06-07      BTC    1.2  7000    0            1.2
                         suploss.range quantity.60days share.left60 sup.loss.quantity
      1 2019-07-15 UTC--2019-09-13 UTC             0.2          0.2               0.0
      2 2019-09-29 UTC--2019-11-28 UTC             0.6          0.8               0.0
      3 2020-05-06 UTC--2020-07-05 UTC             1.2          1.2               0.8
      4 2020-05-08 UTC--2020-07-07 UTC             1.2          1.2               0.0
        sup.loss gains.uncorrected gains.sup gains.excess gains  ACB ACB.share
      1    FALSE                 0        NA           NA    NA 1820      9100
      2    FALSE                 0        NA           NA    NA 6140      7675
      3     TRUE              -440      -440           NA    NA    0         0
      4    FALSE                 0        NA           NA    NA 7440      6200

# Example #10 - Koinly

    Code
      ACB(data_koinly, sup.loss = FALSE)
    Output
              date transaction currency quantity spot.rate total.price fees
      1 2019-01-06         buy      ETH      100        50        5000    0
      2 2019-11-03        sell      ETH      100        30        3000    0
      3 2019-11-04         buy      ETH      100        30        3000    0
        total.quantity  ACB ACB.share gains
      1            100 5000        50    NA
      2              0    0         0 -2000
      3            100 3000        30    NA

---

    Code
      ACB(data_koinly)
    Output
              date transaction currency quantity spot.rate total.price fees
      1 2019-01-06         buy      ETH      100        50        5000    0
      2 2019-11-03        sell      ETH      100        30        3000    0
      3 2019-11-04         buy      ETH      100        30        3000    0
        total.quantity                  suploss.range quantity.60days share.left60
      1            100 2018-12-07 UTC--2019-02-05 UTC             100          100
      2              0 2019-10-04 UTC--2019-12-03 UTC             100          100
      3            100 2019-10-05 UTC--2019-12-04 UTC             100          100
        sup.loss.quantity sup.loss gains.uncorrected gains.sup gains.excess gains
      1                 0    FALSE                 0        NA           NA    NA
      2               100     TRUE             -2000     -2000           NA    NA
      3                 0    FALSE                 0        NA           NA    NA
         ACB ACB.share
      1 5000        50
      2    0         0
      3 5000        50

