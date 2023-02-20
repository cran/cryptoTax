# generic1 - capitals

    Code
      format_generic(data_generic1)
    Output
                       date currency quantity total.price  spot.rate transaction fees
      1 2021-03-02 10:36:06      BTC 0.001240       50.99 41120.9677         buy 0.72
      2 2021-03-10 12:49:04      ETH 0.063067       50.99   808.5052         buy 0.72
      3 2021-03-15 14:12:08      ETH 0.065048      150.99  2321.2090        sell 1.75
                exchange rate.source
      1 generic_exchange    exchange
      2 generic_exchange    exchange
      3 generic_exchange    exchange

# generic2 - different names

    Code
      format_generic(data_generic2, date = "Date.Transaction", currency = "Coin",
        quantity = "Amount", total.price = "Price", transaction = "Type", fees = "Fee",
        exchange = "Platform")
    Output
                       date currency quantity total.price  spot.rate transaction fees
      1 2021-03-02 10:36:06      BTC 0.001240       50.99 41120.9677         buy 0.72
      2 2021-03-10 12:49:04      ETH 0.063067       50.99   808.5052         buy 0.72
      3 2021-03-15 14:12:08      ETH 0.065048      150.99  2321.2090        sell 1.75
                exchange rate.source
      1 generic_exchange    exchange
      2 generic_exchange    exchange
      3 generic_exchange    exchange

# generic3 - calculate total.price

    Code
      format_generic(data_generic3)
    Output
                       date currency quantity total.price  spot.rate transaction fees
      1 2021-03-02 10:36:06      BTC 0.001240       50.99 41120.9677         buy 0.72
      2 2021-03-10 12:49:04      ETH 0.063067       50.99   808.5052         buy 0.72
      3 2021-03-15 14:12:08      ETH 0.065048      150.99  2321.2090        sell 1.75
                exchange
      1 generic_exchange
      2 generic_exchange
      3 generic_exchange

# generic4 - fetch spot.rate

    Code
      format_generic(data_generic4, list.prices = list.prices)
    Output
                       date currency quantity total.price spot.rate transaction fees
      1 2021-03-02 10:36:06      BTC 0.001240    76.78595 61924.154         buy 0.72
      2 2021-03-10 12:49:04      ETH 0.063067   146.11971  2316.896         buy 0.72
      3 2021-03-15 14:12:08      ETH 0.065048   147.90745  2273.820        sell 1.75
                exchange   rate.source
      1 generic_exchange coinmarketcap
      2 generic_exchange coinmarketcap
      3 generic_exchange coinmarketcap

# shakepay

    Code
      format_shakepay(data_shakepay)
    Output
                       date currency    quantity total.price spot.rate transaction
      1 2021-05-07 14:50:41      BTC  0.00103982   53.033350  51002.43         buy
      2 2021-05-07 21:25:36      CAD 30.00000000   30.000000      1.00     revenue
      3 2021-05-08 12:12:57      BTC  0.00011000    5.784024  52582.03     revenue
      4 2021-05-09 12:22:07      BTC  0.00012000    6.034441  50287.01     revenue
      5 2021-05-21 12:47:14      BTC  0.00013000    7.348590  56527.62     revenue
      6 2021-06-11 12:03:31      BTC  0.00014000    8.396927  59978.05     revenue
      7 2021-06-23 12:21:49      BTC  0.00015000    8.714877  58099.18     revenue
      8 2021-07-10 00:52:19      BTC  0.00052991   31.268480  59007.15        sell
          description  comment revenue.type exchange rate.source
      1 purchase/sale purchase         <NA> shakepay    exchange
      2         other   credit    referrals shakepay    exchange
      3   shakingsats   credit     airdrops shakepay    exchange
      4   shakingsats   credit     airdrops shakepay    exchange
      5   shakingsats   credit     airdrops shakepay    exchange
      6   shakingsats   credit     airdrops shakepay    exchange
      7   shakingsats   credit     airdrops shakepay    exchange
      8 purchase/sale     sale         <NA> shakepay    exchange

# newton

    Code
      format_newton(data_newton)
    Output
                       date currency   quantity  total.price  spot.rate transaction
      1 2021-04-04 22:50:12      LTC  0.1048291   23.4912731   224.0911         buy
      2 2021-04-04 22:53:46      CAD 25.0000000   25.0000000     1.0000     revenue
      3 2021-04-04 22:55:55      ETH  2.7198712 3423.8221510  1258.8178         buy
      4 2021-04-21 19:57:26      BTC  0.0034300  153.1241354 44642.6051         buy
      5 2021-05-12 21:37:42      BTC  0.0000040    0.3049013 76225.3175         buy
      6 2021-05-12 21:52:40      BTC  0.0032130  156.1241341 48591.3894        sell
      7 2021-06-16 18:49:11      CAD 25.0000000   25.0000000     1.0000     revenue
             description revenue.type exchange rate.source
      1            TRADE         <NA>   newton    exchange
      2 Referral Program    referrals   newton    exchange
      3            TRADE         <NA>   newton    exchange
      4            TRADE         <NA>   newton    exchange
      5            TRADE         <NA>   newton    exchange
      6            TRADE         <NA>   newton    exchange
      7 Referral Program    referrals   newton    exchange

# pooltool

    Code
      format_pooltool(data_pooltool)
    Output
                        date currency  quantity total.price spot.rate transaction
      1  2021-04-22 22:03:22      ADA 1.0827498    1.974017      1.82     revenue
      2  2021-04-27 22:22:14      ADA 0.8579850    1.565881      1.83     revenue
      3  2021-05-02 22:03:54      ADA 1.0193882    1.979399      1.94     revenue
      4  2021-05-07 22:54:38      ADA 1.0548971    1.790303      1.70     revenue
      5  2021-05-12 22:12:49      ADA 0.9443321    1.514525      1.60     revenue
      6  2021-05-17 22:47:25      ADA 1.0198183    1.426898      1.40     revenue
      7  2021-05-23 03:43:38      ADA 1.1605830    1.806024      1.56     revenue
      8  2021-05-27 22:07:57      ADA 1.0197753    1.589004      1.56     revenue
      9  2021-06-01 22:13:58      ADA 0.8392135    1.538300      1.83     revenue
      10 2021-06-06 22:14:11      ADA 1.1115378    2.072874      1.86     revenue
         description     comment revenue.type exchange rate.source
      1  epoch = 228 pool = REKT      staking   exodus    pooltool
      2  epoch = 229 pool = REKT      staking   exodus    pooltool
      3  epoch = 230 pool = REKT      staking   exodus    pooltool
      4  epoch = 231 pool = REKT      staking   exodus    pooltool
      5  epoch = 232 pool = REKT      staking   exodus    pooltool
      6  epoch = 233 pool = REKT      staking   exodus    pooltool
      7  epoch = 234 pool = REKT      staking   exodus    pooltool
      8  epoch = 235 pool = REKT      staking   exodus    pooltool
      9  epoch = 236 pool = REKT      staking   exodus    pooltool
      10 epoch = 237 pool = REKT      staking   exodus    pooltool

# CDC

    Code
      suppressMessages(format_CDC(data_CDC))
    Output
                        date currency       quantity total.price     spot.rate
      1  2021-05-03 22:05:50      BTC   0.0007333710    51.25000 69882.7777778
      2  2021-05-07 23:06:50      ETH   0.0205920059    54.21000  2632.5750000
      3  2021-05-15 18:07:10      CRO 182.4360090842    53.42000     0.2928150
      4  2021-05-23 22:09:39      CRO 117.9468230300    30.19035     0.2559658
      5  2021-05-29 23:10:59      CRO   6.4039544538     1.13000     0.1764535
      6  2021-06-02 19:11:52      CRO  53.6136687700    10.99000     0.2049850
      7  2021-06-10 23:12:24      CRO  86.3572366500    16.94000     0.1961619
      8  2021-06-11 19:13:58      CRO  17.3688994200     9.19000     0.5291066
      9  2021-06-16 20:14:29      CRO  22.5041772606    11.65000     0.5176817
      10 2021-06-18 21:15:51      ETH   0.0000137750     0.05000  3629.7640653
      11 2021-06-19 21:16:30      CRO   8.4526209677     1.25000     0.1478831
      12 2021-06-27 21:17:50      ETH   0.0007632668     3.12000  4087.6923838
      13 2021-07-06 22:18:40      CRO   0.3207992131     0.26000     0.8104758
      14 2021-07-11 20:19:55     ETHW   0.3558067180     3.20000     8.9936469
      15 2021-07-14 18:20:27      CRO   2.4761904762     1.20000     0.4846154
      16 2021-07-23 17:21:19      CRO  37.1602562661     6.98000     0.1878351
      17 2021-07-25 18:22:02      BTC   0.0005320542    35.00000 65782.7775510
      18 2021-07-28 23:23:04      ETH   0.0099636548    35.00000  3512.7672130
         transaction                         description                   comment
      1          buy                     crypto_purchase                   Buy BTC
      2          buy                     crypto_purchase                   Buy ETH
      3          buy                     crypto_purchase                   Buy CRO
      4      revenue                       referral_gift    Sign-up Bonus Unlocked
      5      revenue              referral_card_cashback             Card Cashback
      6      revenue                       reimbursement      Card Rebate: Spotify
      7      revenue                       reimbursement      Card Rebate: Netflix
      8      revenue                       reimbursement Card Rebate: Amazon Prime
      9      revenue                       reimbursement      Card Rebate: Expedia
      10     revenue supercharger_reward_to_app_credited       Supercharger Reward
      11     revenue                 pay_checkout_reward               Pay Rewards
      12     revenue           crypto_earn_interest_paid               Crypto Earn
      13     revenue     crypto_earn_extra_interest_paid       Crypto Earn (Extra)
      14     revenue               admin_wallet_credited       Adjustment (Credit)
      15     revenue   rewards_platform_deposit_credited   Mission Rewards Deposit
      16     revenue                    mco_stake_reward         CRO Stake Rewards
      17        sell               crypto_viban_exchange                BTC -> CAD
      18        sell               crypto_viban_exchange                ETH -> CAD
                                revenue.type exchange               rate.source
      1                                 <NA>      CDC                  exchange
      2                                 <NA>      CDC                  exchange
      3                                 <NA>      CDC                  exchange
      4                            referrals      CDC exchange (USD conversion)
      5                              rebates      CDC                  exchange
      6                              rebates      CDC                  exchange
      7                              rebates      CDC                  exchange
      8                              rebates      CDC                  exchange
      9                              rebates      CDC                  exchange
      10 supercharger_reward_to_app_credited      CDC                  exchange
      11                             rebates      CDC                  exchange
      12                           interests      CDC                  exchange
      13                           interests      CDC                  exchange
      14                               forks      CDC                  exchange
      15                             rewards      CDC                  exchange
      16                           interests      CDC                  exchange
      17                                <NA>      CDC                  exchange
      18                                <NA>      CDC                  exchange

# celsius

    Code
      format_celsius(data_celsius)
    Output
                       date currency       quantity total.price  spot.rate
      1 2021-03-03 21:11:00      BTC 0.000707598916  50.6235600  71542.733
      2 2021-03-07 05:00:00      BTC 0.000025237883   0.1364482   5406.484
      3 2021-03-19 05:00:00      BTC 0.000081561209   0.7278227   8923.638
      4 2021-03-28 05:00:00      BTC 0.000003683063   0.5977337 162292.567
      5 2021-04-05 05:00:00      BTC 0.000046940391   0.5847333  12456.934
      6 2021-04-08 05:00:00      BTC 0.000051775622   0.6441503  12441.189
      7 2021-04-08 22:18:00      BTC 0.000733082450  50.2662400  68568.331
      8 2021-05-06 10:32:00      BTC 0.001409023441  60.7813000  43137.182
      9 2021-05-23 05:00:00      BTC 0.000063726694   0.4167779   6540.084
        transaction       description revenue.type exchange               rate.source
      1     revenue Promo Code Reward       promos  celsius exchange (USD conversion)
      2     revenue            Reward    interests  celsius exchange (USD conversion)
      3     revenue            Reward    interests  celsius exchange (USD conversion)
      4     revenue            Reward    interests  celsius exchange (USD conversion)
      5     revenue            Reward    interests  celsius exchange (USD conversion)
      6     revenue            Reward    interests  celsius exchange (USD conversion)
      7     revenue    Referred Award    referrals  celsius exchange (USD conversion)
      8     revenue Promo Code Reward       promos  celsius exchange (USD conversion)
      9     revenue            Reward    interests  celsius exchange (USD conversion)

# adalite

    Code
      format_adalite(data_adalite, list.prices = list.prices)
    Output
                       date currency  quantity total.price spot.rate transaction
      1 2021-04-28 16:56:00      ADA 0.3120400   0.5091943  1.631824     revenue
      2 2021-05-07 16:53:00      ADA 0.3125132   0.6266931  2.005333     revenue
      3 2021-05-12 16:56:00      ADA 0.2212410   0.4441940  2.007738     revenue
      4 2021-05-17 17:16:00      ADA 0.4123210   1.0798503  2.618955     revenue
      5 2021-05-17 21:16:00      ADA 0.1691870   0.4430932  2.618955        sell
      6 2021-05-17 21:31:00      ADA 0.1912300   0.5008228  2.618955        sell
           description        comment revenue.type exchange   rate.source
      1 Reward awarded           <NA>      staking  adalite coinmarketcap
      2 Reward awarded           <NA>      staking  adalite coinmarketcap
      3 Reward awarded           <NA>      staking  adalite coinmarketcap
      4 Reward awarded           <NA>      staking  adalite coinmarketcap
      5           Sent Withdrawal Fee         <NA>  adalite coinmarketcap
      6           Sent Withdrawal Fee         <NA>  adalite coinmarketcap

# binance

    Code
      format_binance(data_binance, list.prices = list.prices)
    Output
                        date currency   quantity     total.price   spot.rate
      1  2021-05-29 17:07:20      LTC 2.53200000  521.6626161494  206.027889
      2  2021-05-29 17:07:20      ETH 0.19521000  521.6626161494 2672.315026
      3  2021-05-29 17:07:20      LTC 2.41210000  496.9598722014  206.027889
      4  2021-05-29 17:07:20      ETH 0.14123140  496.9598722014 3518.763336
      5  2021-05-29 17:07:20      LTC 1.45120000  298.9876732054  206.027889
      6  2021-05-29 17:07:20      ETH 0.11240000  298.9876732054 2660.032680
      7  2021-05-29 17:07:20      LTC 1.42100000  292.7656309433  206.027889
      8  2021-05-29 17:07:20      ETH 0.10512900  292.7656309433 2784.822751
      9  2021-05-29 17:07:20      LTC 0.30000000   61.8083668423  206.027889
      10 2021-05-29 17:07:20      ETH 0.00899120   61.8083668423 6874.317871
      11 2021-05-29 17:07:20      LTC 0.27000000   55.6275301581  206.027889
      12 2021-05-29 17:07:20      ETH 0.00612410   55.6275301581 9083.380441
      13 2021-05-29 17:07:20      LTC 0.00202500    0.4172064762  206.027889
      14 2021-05-29 17:07:20      LTC 0.00127520    0.2627267647  206.027889
      15 2021-05-29 17:07:20      LTC 0.00113100    0.2330175430  206.027889
      16 2021-05-29 17:07:20      LTC 0.00049230    0.1014275300  206.027889
      17 2021-05-29 17:07:20      LTC 0.00007000    0.0144219523  206.027889
      18 2021-05-29 17:07:20      LTC 0.00005000    0.0103013945  206.027889
      19 2021-05-29 18:12:55      ETH 0.44124211 1250.5929350551 2834.255631
      20 2021-05-29 18:12:55      LTC 1.60000000 1250.5929350551  781.620584
      21 2021-05-29 18:12:55      ETH 0.42124000 1193.9018421488 2834.255631
      22 2021-05-29 18:12:55      LTC 1.23000000 1193.9018421488  970.651904
      23 2021-05-29 18:12:55      ETH 0.00021470    0.6085146841 2834.255631
      24 2021-05-29 18:12:55      ETH 0.00009251    0.2621969885 2834.255631
      25 2021-11-05 04:32:23     BUSD 0.10512330    0.1309574574    1.245751
      26 2022-11-17 11:54:25     ETHW 0.00012050    0.0006084561    5.049428
      27 2022-11-27 08:05:35     USDC 5.77124200    7.7366916521    1.340559
      28 2022-11-27 08:05:35     BUSD 5.77124200    7.7365241364    1.340530
         transaction       fees                   description comment revenue.type
      1          buy 1.52893297                           Buy    Spot         <NA>
      2         sell         NA                           Buy    Spot         <NA>
      3          buy 1.19743409                           Buy    Spot         <NA>
      4         sell         NA                           Buy    Spot         <NA>
      5          buy 1.11687719                           Buy    Spot         <NA>
      6         sell         NA                           Buy    Spot         <NA>
      7          buy 0.64342510                           Buy    Spot         <NA>
      8         sell         NA                           Buy    Spot         <NA>
      9          buy 0.06180837                           Buy    Spot         <NA>
      10        sell         NA                           Buy    Spot         <NA>
      11         buy 0.04326586                           Buy    Spot         <NA>
      12        sell         NA                           Buy    Spot         <NA>
      13     revenue         NA             Referral Kickback    Spot      rebates
      14     revenue         NA             Referral Kickback    Spot      rebates
      15     revenue         NA             Referral Kickback    Spot      rebates
      16     revenue         NA             Referral Kickback    Spot      rebates
      17     revenue         NA             Referral Kickback    Spot      rebates
      18     revenue         NA             Referral Kickback    Spot      rebates
      19         buy 6.01747615                          Sell    Spot         <NA>
      20        sell         NA                          Sell    Spot         <NA>
      21         buy 1.73569815                          Sell    Spot         <NA>
      22        sell         NA                          Sell    Spot         <NA>
      23     revenue         NA             Referral Kickback    Spot      rebates
      24     revenue         NA             Referral Kickback    Spot      rebates
      25     revenue         NA Simple Earn Flexible Interest    Earn    interests
      26     revenue         NA                  Distribution    Spot        forks
      27        sell         NA   Stablecoins Auto-Conversion    Spot         <NA>
      28         buy         NA   Stablecoins Auto-Conversion    Spot         <NA>
         exchange               rate.source
      1   binance             coinmarketcap
      2   binance coinmarketcap (buy price)
      3   binance             coinmarketcap
      4   binance coinmarketcap (buy price)
      5   binance             coinmarketcap
      6   binance coinmarketcap (buy price)
      7   binance             coinmarketcap
      8   binance coinmarketcap (buy price)
      9   binance             coinmarketcap
      10  binance coinmarketcap (buy price)
      11  binance             coinmarketcap
      12  binance coinmarketcap (buy price)
      13  binance             coinmarketcap
      14  binance             coinmarketcap
      15  binance             coinmarketcap
      16  binance             coinmarketcap
      17  binance             coinmarketcap
      18  binance             coinmarketcap
      19  binance             coinmarketcap
      20  binance coinmarketcap (buy price)
      21  binance             coinmarketcap
      22  binance coinmarketcap (buy price)
      23  binance             coinmarketcap
      24  binance             coinmarketcap
      25  binance             coinmarketcap
      26  binance             coinmarketcap
      27  binance             coinmarketcap
      28  binance             coinmarketcap

# binance withdrawals

    Code
      format_binance_withdrawals(data_binance_withdrawals, list.prices = list.prices)
    Output
                       date currency quantity total.price spot.rate transaction
      1 2021-04-28 17:13:50      LTC 0.001000   0.3201871  320.1871        sell
      2 2021-04-28 18:15:14      ETH 0.000071   0.2373204 3342.5405        sell
      3 2021-05-06 19:55:52      ETH 0.000062   0.2656118 4284.0612        sell
            description exchange   rate.source
      1 Withdrawal fees  binance coinmarketcap
      2 Withdrawal fees  binance coinmarketcap
      3 Withdrawal fees  binance coinmarketcap

# blockfi

    Code
      format_blockfi(data_blockfi, list.prices = list.prices)
    Output
                       date currency     quantity total.price    spot.rate
      1 2021-05-29 21:43:44      LTC  0.022451200   4.6255734   206.027889
      2 2021-05-29 21:43:44      BTC  0.000018512   0.7858598 42451.369876
      3 2021-06-13 21:43:44      BTC  0.000184120   8.3556212 45381.388034
      4 2021-06-30 21:43:44      BTC  0.000047234   2.0770535 43973.694092
      5 2021-06-30 21:43:44      LTC  0.010125120   1.8084980   178.614968
      6 2021-07-29 21:43:44     USDC  0.038241000   0.0477449     1.248526
      7 2021-08-07 21:43:44      BTC  0.000441230  24.2005138 54847.843168
      8 2021-10-24 04:29:23     USDC 55.000000000  68.0777573     1.237777
      9 2021-10-24 04:29:23      LTC  0.165122140  68.0777573   412.287276
        transaction      description revenue.type exchange               rate.source
      1     revenue Interest Payment    interests  blockfi             coinmarketcap
      2     revenue Interest Payment    interests  blockfi             coinmarketcap
      3     revenue   Referral Bonus    referrals  blockfi             coinmarketcap
      4     revenue Interest Payment    interests  blockfi             coinmarketcap
      5     revenue Interest Payment    interests  blockfi             coinmarketcap
      6     revenue Interest Payment    interests  blockfi             coinmarketcap
      7     revenue    Bonus Payment       promos  blockfi             coinmarketcap
      8         buy            Trade         <NA>  blockfi             coinmarketcap
      9        sell            Trade         <NA>  blockfi coinmarketcap (buy price)

# CDC exchange rewards

    Code
      format_CDC_exchange_rewards(data_CDC_exchange_rewards, list.prices = list.prices)
    Output
                        date currency   quantity  total.price     spot.rate
      1  2021-02-19 00:00:00      CRO 1.36512341 0.2227899953     0.1632014
      2  2021-02-21 00:00:00      CRO 1.36945123 0.2411195812     0.1760702
      3  2021-04-15 16:04:21      BTC 0.00000023 0.0182149274 79195.3367033
      4  2021-04-18 00:00:00      CRO 1.36512310 0.3798900187     0.2782826
      5  2021-05-14 06:02:22      BTC 0.00000035 0.0211513332 60432.3807116
      6  2021-06-12 15:21:34      BTC 0.00000630 0.2791139040 44303.7942802
      7  2021-06-27 01:34:00      CRO 0.00100000 0.0001239785     0.1239785
      8  2021-07-07 00:00:00      CRO 0.01512903 0.0022872188     0.1511808
      9  2021-07-13 00:00:00      CRO 0.05351230 0.0084128916     0.1572142
      10 2021-09-07 00:00:00      CRO 0.01521310 0.0035626681     0.2341842
         transaction description                                          comment
      1      revenue      Reward Interest on 5000.00000000 at 10% APR (Completed)
      2      revenue      Reward Interest on 5000.00000000 at 10% APR (Completed)
      3      revenue      Reward                          BTC Supercharger reward
      4      revenue      Reward Interest on 5000.00000000 at 10% APR (Completed)
      5      revenue      Reward                          BTC Supercharger reward
      6      revenue      Reward                          BTC Supercharger reward
      7         sell  Withdrawal                                             <NA>
      8      revenue      Reward                  Rebate on 0.18512341 CRO at 10%
      9      revenue      Reward                Rebate on 0.5231512346 CRO at 10%
      10     revenue      Reward                 Rebate on 0.155125123 CRO at 10%
         revenue.type     exchange   rate.source
      1     interests CDC.exchange coinmarketcap
      2     interests CDC.exchange coinmarketcap
      3     interests CDC.exchange coinmarketcap
      4     interests CDC.exchange coinmarketcap
      5     interests CDC.exchange coinmarketcap
      6     interests CDC.exchange coinmarketcap
      7          <NA> CDC.exchange coinmarketcap
      8       rebates CDC.exchange coinmarketcap
      9       rebates CDC.exchange coinmarketcap
      10      rebates CDC.exchange coinmarketcap

# CDC exchange trades

    Code
      format_CDC_exchange_trades(data_CDC_exchange_trades, list.prices = list.prices)
    Output
                        date currency   quantity total.price    spot.rate transaction
      1  2021-12-24 15:34:45      CRO 13260.1300 10386.66313    0.7833002         buy
      2  2021-12-24 15:34:45      ETH     2.0932 10386.66313 4962.0978083        sell
      3  2021-12-24 15:34:45      CRO  3555.9000  2785.33736    0.7833002         buy
      4  2021-12-24 15:34:45      ETH     0.5600  2785.33736 4973.8167068        sell
      5  2021-12-24 15:34:45      CRO  1781.7400  1395.63739    0.7833002         buy
      6  2021-12-24 15:34:45      ETH     0.2800  1395.63739 4984.4192352        sell
      7  2021-12-24 15:34:45      CRO    26.8500    21.03161    0.7833002         buy
      8  2021-12-24 15:34:45      ETH     0.0042    21.03161 5007.5265925        sell
      9  2021-12-24 15:34:45      CRO    26.6700    20.89062    0.7833002         buy
      10 2021-12-24 15:34:45      ETH     0.0042    20.89062 4973.9565819        sell
      11 2021-12-24 15:34:45      CRO    17.7800    13.92708    0.7833002         buy
      12 2021-12-24 15:34:45      CRO    17.7800    13.92708    0.7833002         buy
      13 2021-12-24 15:34:45      ETH     0.0028    13.92708 4973.9565819        sell
      14 2021-12-24 15:34:45      ETH     0.0028    13.92708 4973.9565819        sell
                fees description comment     exchange               rate.source
      1           NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      2  41.54665616        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      3           NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      4  11.14134692        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      5           NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      6   5.58256082        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      7           NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      8   0.08413730        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      9           NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      10  0.08355905        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      11          NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      12          NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      13  0.05570691        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      14  0.05570683        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)

# CDC wallet

    Code
      format_CDC_wallet(data_CDC_wallet, list.prices = list.prices)
    Output
                       date currency quantity   total.price spot.rate transaction
      1 2021-04-12 18:28:50      CRO 0.512510 0.13593610436 0.2652360     revenue
      2 2021-04-23 18:51:53      CRO 1.656708 0.36013687043 0.2173811     revenue
      3 2021-05-21 01:19:01      CRO 0.000200 0.00002993323 0.1496661        sell
      4 2021-06-26 14:51:02      CRO 6.051235 0.70769054418 0.1169498     revenue
        description                                            comment revenue.type
      1      Reward                         Auto Withdraw Reward from       staking
      2      Reward                         Auto Withdraw Reward from       staking
      3  Withdrawal Outgoing Transaction to abcdefghijklmnopqrstuvwxyz         <NA>
      4      Reward    Withdraw Reward from abcdefghijklmnopqrstuvwxyz      staking
          exchange   rate.source
      1 CDC.wallet coinmarketcap
      2 CDC.wallet coinmarketcap
      3 CDC.wallet coinmarketcap
      4 CDC.wallet coinmarketcap

# coinsmart

    Code
      format_coinsmart(data_coinsmart, list.prices = list.prices)
    Output
                       date currency  quantity total.price    spot.rate transaction
      1 2021-04-25 16:11:24      ADA 198.50000 237.9374300     1.198677         buy
      2 2021-04-28 18:37:15      CAD  15.00000  15.0000000     1.000000     revenue
      3 2021-05-15 16:42:07      BTC   0.00004   2.3397033 58492.582640     revenue
      4 2021-06-03 02:04:49      ADA   0.30000   0.6512228     2.170743        sell
            fees description  comment revenue.type  exchange   rate.source
      1 0.269386    purchase    Trade         <NA> coinsmart      exchange
      2       NA       Other Referral    referrals coinsmart      exchange
      3       NA       Other     Quiz     airdrops coinsmart coinmarketcap
      4       NA         Fee Withdraw         <NA> coinsmart coinmarketcap

# exodus

    Code
      format_exodus(data_exodus, list.prices = list.prices)
    Output
                       date currency  quantity total.price    spot.rate transaction
      1 2021-05-25 22:06:11      LTC 0.0014430   0.3206295   222.196455        sell
      2 2021-05-25 23:08:12      ADA 0.1782410   0.3337586     1.872513        sell
      3 2021-06-12 12:15:28      BTC 0.0000503   2.2284809 44303.794280        sell
      4 2021-06-12 22:31:35      ETH 0.0014500   4.1661267  2873.190813        sell
        description revenue.type exchange   rate.source
      1  withdrawal         <NA>   exodus coinmarketcap
      2  withdrawal         <NA>   exodus coinmarketcap
      3  withdrawal         <NA>   exodus coinmarketcap
      4  withdrawal         <NA>   exodus coinmarketcap

# presearch

    Code
      format_presearch(data_presearch, list.prices = list.prices)
    Output
                        date currency quantity total.price  spot.rate transaction
      1  2021-04-27 17:45:18      PRE     0.13  0.01209844 0.09306492     revenue
      2  2021-04-27 17:48:00      PRE     0.13  0.01209844 0.09306492     revenue
      3  2021-04-27 17:48:18      PRE     0.13  0.01209844 0.09306492     revenue
      4  2021-04-27 17:55:24      PRE     0.13  0.01209844 0.09306492     revenue
      5  2021-04-27 17:57:29      PRE     0.13  0.01209844 0.09306492     revenue
      6  2021-04-27 19:00:31      PRE     0.13  0.01209844 0.09306492     revenue
      7  2021-04-27 19:00:41      PRE     0.13  0.01209844 0.09306492     revenue
      8  2021-04-27 19:01:57      PRE     0.13  0.01209844 0.09306492     revenue
      9  2021-04-27 19:08:59      PRE     0.13  0.01209844 0.09306492     revenue
      10 2021-04-27 19:12:15      PRE     0.13  0.01209844 0.09306492     revenue
      11 2021-05-07 05:55:33      PRE  1000.00 78.90639103 0.07890639         buy
                                             description revenue.type  exchange
      1                                    Search Reward     airdrops presearch
      2                                    Search Reward     airdrops presearch
      3                                    Search Reward     airdrops presearch
      4                                    Search Reward     airdrops presearch
      5                                    Search Reward     airdrops presearch
      6                                    Search Reward     airdrops presearch
      7                                    Search Reward     airdrops presearch
      8                                    Search Reward     airdrops presearch
      9                                    Search Reward     airdrops presearch
      10                                   Search Reward     airdrops presearch
      11 Transferred from Presearch Portal (PO#: 412893)         <NA> presearch
           rate.source
      1  coinmarketcap
      2  coinmarketcap
      3  coinmarketcap
      4  coinmarketcap
      5  coinmarketcap
      6  coinmarketcap
      7  coinmarketcap
      8  coinmarketcap
      9  coinmarketcap
      10 coinmarketcap
      11 coinmarketcap

# gemini

    Code
      format_gemini(data_gemini, list.prices = list.prices)
    Output
                        date currency        quantity total.price     spot.rate
      1  2021-04-09 22:50:55      BTC  0.000966278356  70.6618968 73127.8895000
      2  2021-04-09 22:50:55      LTC  0.246690598398  70.6618968   286.4393588
      3  2021-04-09 22:53:57      BTC  0.000006051912   0.4425635 73127.8895000
      4  2021-04-09 22:53:57      LTC  0.001640820000   0.4425635   269.7209419
      5  2021-04-09 23:20:53      BAT 48.719519585106  86.3881744     1.7731738
      6  2021-04-09 23:20:53      BTC  0.000950730015  86.3881744 90865.0963117
      7  2021-04-10 23:22:04      BTC  0.000285025578  21.0788079 73954.0922149
      8  2021-05-08 16:14:54      BAT  2.833934780210   4.8581158     1.7142652
      9  2021-05-16 12:55:02      BAT  3.085288331282   4.2582521     1.3801796
      10 2021-05-16 13:35:19      BAT  5.007481461482   6.9112238     1.3801796
      11 2021-06-18 01:38:54      BAT  6.834322542857   5.3875147     0.7883027
         transaction            fees description               comment revenue.type
      1          buy 0.0000023034086      LTCBTC                Market         <NA>
      2         sell              NA      LTCBTC                Market         <NA>
      3          buy 0.0000000365181      LTCBTC                 Limit         <NA>
      4         sell              NA      LTCBTC                 Limit         <NA>
      5          buy              NA      BATBTC                 Limit         <NA>
      6         sell 0.0000018142411      BATBTC                 Limit         <NA>
      7      revenue              NA      Credit Administrative Credit    referrals
      8      revenue              NA      Credit Administrative Credit    referrals
      9      revenue              NA      Credit               Deposit     airdrops
      10     revenue              NA      Credit               Deposit     airdrops
      11     revenue              NA      Credit               Deposit     airdrops
         exchange               rate.source
      1    gemini             coinmarketcap
      2    gemini coinmarketcap (buy price)
      3    gemini             coinmarketcap
      4    gemini coinmarketcap (buy price)
      5    gemini             coinmarketcap
      6    gemini coinmarketcap (buy price)
      7    gemini             coinmarketcap
      8    gemini             coinmarketcap
      9    gemini             coinmarketcap
      10   gemini             coinmarketcap
      11   gemini             coinmarketcap

# uphold

    Code
      format_uphold(data_uphold, list.prices = list.prices)
    Output
                        date currency    quantity total.price   spot.rate transaction
      1  2021-01-07 02:40:31      BAT  1.59081275   0.5114264   0.3214875     revenue
      2  2021-02-09 14:26:49      BAT 12.69812163   6.8805827   0.5418583     revenue
      3  2021-03-06 21:32:36      BAT  0.37591275   0.3203871   0.8522910     revenue
      4  2021-03-07 21:46:57      LTC  0.24129740  57.0095475 236.2625850         buy
      5  2021-03-07 21:46:57      BAT 52.59871206  57.0095475   1.0838582        sell
      6  2021-03-07 21:54:09      LTC  0.00300000   0.7087878 236.2625850        sell
      7  2021-04-05 12:22:00      BAT  8.52198415  13.2125179   1.5504039     revenue
      8  2021-04-06 03:41:42      LTC  0.00300000   0.8643769 288.1256316        sell
      9  2021-04-06 04:47:00      LTC  0.03605981  10.3897561 288.1256316         buy
      10 2021-04-06 04:47:00      BAT  8.52198415  10.3897561   1.2191710        sell
      11 2021-05-11 07:12:24      BAT  0.47521985   0.7777261   1.6365606     revenue
      12 2021-06-09 04:52:23      BAT  0.67207415   0.5586404   0.8312183     revenue
         description         comment revenue.type exchange               rate.source
      1           in            <NA>     airdrops   uphold             coinmarketcap
      2           in            <NA>     airdrops   uphold             coinmarketcap
      3           in            <NA>     airdrops   uphold             coinmarketcap
      4        trade         BAT-LTC         <NA>   uphold             coinmarketcap
      5        trade         BAT-LTC         <NA>   uphold coinmarketcap (buy price)
      6          out withdrawal fees         <NA>   uphold             coinmarketcap
      7           in            <NA>     airdrops   uphold             coinmarketcap
      8          out withdrawal fees         <NA>   uphold             coinmarketcap
      9        trade         BAT-LTC         <NA>   uphold             coinmarketcap
      10       trade         BAT-LTC         <NA>   uphold coinmarketcap (buy price)
      11          in            <NA>     airdrops   uphold             coinmarketcap
      12          in            <NA>     airdrops   uphold             coinmarketcap

# format_detect single

    Code
      format_detect(data_shakepay)
    Message <simpleMessage>
      Exchange detected: shakepay
    Output
                       date currency    quantity total.price spot.rate transaction
      1 2021-05-07 14:50:41      BTC  0.00103982   53.033350  51002.43         buy
      2 2021-05-07 21:25:36      CAD 30.00000000   30.000000      1.00     revenue
      3 2021-05-08 12:12:57      BTC  0.00011000    5.784024  52582.03     revenue
      4 2021-05-09 12:22:07      BTC  0.00012000    6.034441  50287.01     revenue
      5 2021-05-21 12:47:14      BTC  0.00013000    7.348590  56527.62     revenue
      6 2021-06-11 12:03:31      BTC  0.00014000    8.396927  59978.05     revenue
      7 2021-06-23 12:21:49      BTC  0.00015000    8.714877  58099.18     revenue
      8 2021-07-10 00:52:19      BTC  0.00052991   31.268480  59007.15        sell
          description  comment revenue.type exchange rate.source
      1 purchase/sale purchase         <NA> shakepay    exchange
      2         other   credit    referrals shakepay    exchange
      3   shakingsats   credit     airdrops shakepay    exchange
      4   shakingsats   credit     airdrops shakepay    exchange
      5   shakingsats   credit     airdrops shakepay    exchange
      6   shakingsats   credit     airdrops shakepay    exchange
      7   shakingsats   credit     airdrops shakepay    exchange
      8 purchase/sale     sale         <NA> shakepay    exchange

---

    Code
      format_detect(data_newton)
    Message <simpleMessage>
      Exchange detected: newton
    Output
                       date currency   quantity  total.price  spot.rate transaction
      1 2021-04-04 22:50:12      LTC  0.1048291   23.4912731   224.0911         buy
      2 2021-04-04 22:53:46      CAD 25.0000000   25.0000000     1.0000     revenue
      3 2021-04-04 22:55:55      ETH  2.7198712 3423.8221510  1258.8178         buy
      4 2021-04-21 19:57:26      BTC  0.0034300  153.1241354 44642.6051         buy
      5 2021-05-12 21:37:42      BTC  0.0000040    0.3049013 76225.3175         buy
      6 2021-05-12 21:52:40      BTC  0.0032130  156.1241341 48591.3894        sell
      7 2021-06-16 18:49:11      CAD 25.0000000   25.0000000     1.0000     revenue
             description revenue.type exchange rate.source
      1            TRADE         <NA>   newton    exchange
      2 Referral Program    referrals   newton    exchange
      3            TRADE         <NA>   newton    exchange
      4            TRADE         <NA>   newton    exchange
      5            TRADE         <NA>   newton    exchange
      6            TRADE         <NA>   newton    exchange
      7 Referral Program    referrals   newton    exchange

---

    Code
      format_detect(data_pooltool)
    Message <simpleMessage>
      Exchange detected: pooltool
    Output
                        date currency  quantity total.price spot.rate transaction
      1  2021-04-22 22:03:22      ADA 1.0827498    1.974017      1.82     revenue
      2  2021-04-27 22:22:14      ADA 0.8579850    1.565881      1.83     revenue
      3  2021-05-02 22:03:54      ADA 1.0193882    1.979399      1.94     revenue
      4  2021-05-07 22:54:38      ADA 1.0548971    1.790303      1.70     revenue
      5  2021-05-12 22:12:49      ADA 0.9443321    1.514525      1.60     revenue
      6  2021-05-17 22:47:25      ADA 1.0198183    1.426898      1.40     revenue
      7  2021-05-23 03:43:38      ADA 1.1605830    1.806024      1.56     revenue
      8  2021-05-27 22:07:57      ADA 1.0197753    1.589004      1.56     revenue
      9  2021-06-01 22:13:58      ADA 0.8392135    1.538300      1.83     revenue
      10 2021-06-06 22:14:11      ADA 1.1115378    2.072874      1.86     revenue
         description     comment revenue.type exchange rate.source
      1  epoch = 228 pool = REKT      staking   exodus    pooltool
      2  epoch = 229 pool = REKT      staking   exodus    pooltool
      3  epoch = 230 pool = REKT      staking   exodus    pooltool
      4  epoch = 231 pool = REKT      staking   exodus    pooltool
      5  epoch = 232 pool = REKT      staking   exodus    pooltool
      6  epoch = 233 pool = REKT      staking   exodus    pooltool
      7  epoch = 234 pool = REKT      staking   exodus    pooltool
      8  epoch = 235 pool = REKT      staking   exodus    pooltool
      9  epoch = 236 pool = REKT      staking   exodus    pooltool
      10 epoch = 237 pool = REKT      staking   exodus    pooltool

---

    Code
      format_detect(data_CDC)
    Message <simpleMessage>
      Exchange detected: CDC
    Output
                        date currency       quantity total.price     spot.rate
      1  2021-05-03 22:05:50      BTC   0.0007333710    51.25000 69882.7777778
      2  2021-05-07 23:06:50      ETH   0.0205920059    54.21000  2632.5750000
      3  2021-05-15 18:07:10      CRO 182.4360090842    53.42000     0.2928150
      4  2021-05-23 22:09:39      CRO 117.9468230300    30.19035     0.2559658
      5  2021-05-29 23:10:59      CRO   6.4039544538     1.13000     0.1764535
      6  2021-06-02 19:11:52      CRO  53.6136687700    10.99000     0.2049850
      7  2021-06-10 23:12:24      CRO  86.3572366500    16.94000     0.1961619
      8  2021-06-11 19:13:58      CRO  17.3688994200     9.19000     0.5291066
      9  2021-06-16 20:14:29      CRO  22.5041772606    11.65000     0.5176817
      10 2021-06-18 21:15:51      ETH   0.0000137750     0.05000  3629.7640653
      11 2021-06-19 21:16:30      CRO   8.4526209677     1.25000     0.1478831
      12 2021-06-27 21:17:50      ETH   0.0007632668     3.12000  4087.6923838
      13 2021-07-06 22:18:40      CRO   0.3207992131     0.26000     0.8104758
      14 2021-07-11 20:19:55     ETHW   0.3558067180     3.20000     8.9936469
      15 2021-07-14 18:20:27      CRO   2.4761904762     1.20000     0.4846154
      16 2021-07-23 17:21:19      CRO  37.1602562661     6.98000     0.1878351
      17 2021-07-25 18:22:02      BTC   0.0005320542    35.00000 65782.7775510
      18 2021-07-28 23:23:04      ETH   0.0099636548    35.00000  3512.7672130
         transaction                         description                   comment
      1          buy                     crypto_purchase                   Buy BTC
      2          buy                     crypto_purchase                   Buy ETH
      3          buy                     crypto_purchase                   Buy CRO
      4      revenue                       referral_gift    Sign-up Bonus Unlocked
      5      revenue              referral_card_cashback             Card Cashback
      6      revenue                       reimbursement      Card Rebate: Spotify
      7      revenue                       reimbursement      Card Rebate: Netflix
      8      revenue                       reimbursement Card Rebate: Amazon Prime
      9      revenue                       reimbursement      Card Rebate: Expedia
      10     revenue supercharger_reward_to_app_credited       Supercharger Reward
      11     revenue                 pay_checkout_reward               Pay Rewards
      12     revenue           crypto_earn_interest_paid               Crypto Earn
      13     revenue     crypto_earn_extra_interest_paid       Crypto Earn (Extra)
      14     revenue               admin_wallet_credited       Adjustment (Credit)
      15     revenue   rewards_platform_deposit_credited   Mission Rewards Deposit
      16     revenue                    mco_stake_reward         CRO Stake Rewards
      17        sell               crypto_viban_exchange                BTC -> CAD
      18        sell               crypto_viban_exchange                ETH -> CAD
                                revenue.type exchange               rate.source
      1                                 <NA>      CDC                  exchange
      2                                 <NA>      CDC                  exchange
      3                                 <NA>      CDC                  exchange
      4                            referrals      CDC exchange (USD conversion)
      5                              rebates      CDC                  exchange
      6                              rebates      CDC                  exchange
      7                              rebates      CDC                  exchange
      8                              rebates      CDC                  exchange
      9                              rebates      CDC                  exchange
      10 supercharger_reward_to_app_credited      CDC                  exchange
      11                             rebates      CDC                  exchange
      12                           interests      CDC                  exchange
      13                           interests      CDC                  exchange
      14                               forks      CDC                  exchange
      15                             rewards      CDC                  exchange
      16                           interests      CDC                  exchange
      17                                <NA>      CDC                  exchange
      18                                <NA>      CDC                  exchange

---

    Code
      format_detect(data_celsius)
    Message <simpleMessage>
      Exchange detected: celsius
    Output
                       date currency       quantity total.price  spot.rate
      1 2021-03-03 21:11:00      BTC 0.000707598916  50.6235600  71542.733
      2 2021-03-07 05:00:00      BTC 0.000025237883   0.1364482   5406.484
      3 2021-03-19 05:00:00      BTC 0.000081561209   0.7278227   8923.638
      4 2021-03-28 05:00:00      BTC 0.000003683063   0.5977337 162292.567
      5 2021-04-05 05:00:00      BTC 0.000046940391   0.5847333  12456.934
      6 2021-04-08 05:00:00      BTC 0.000051775622   0.6441503  12441.189
      7 2021-04-08 22:18:00      BTC 0.000733082450  50.2662400  68568.331
      8 2021-05-06 10:32:00      BTC 0.001409023441  60.7813000  43137.182
      9 2021-05-23 05:00:00      BTC 0.000063726694   0.4167779   6540.084
        transaction       description revenue.type exchange               rate.source
      1     revenue Promo Code Reward       promos  celsius exchange (USD conversion)
      2     revenue            Reward    interests  celsius exchange (USD conversion)
      3     revenue            Reward    interests  celsius exchange (USD conversion)
      4     revenue            Reward    interests  celsius exchange (USD conversion)
      5     revenue            Reward    interests  celsius exchange (USD conversion)
      6     revenue            Reward    interests  celsius exchange (USD conversion)
      7     revenue    Referred Award    referrals  celsius exchange (USD conversion)
      8     revenue Promo Code Reward       promos  celsius exchange (USD conversion)
      9     revenue            Reward    interests  celsius exchange (USD conversion)

---

    Code
      format_detect(data_adalite, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: adalite
    Output
                       date currency  quantity total.price spot.rate transaction
      1 2021-04-28 16:56:00      ADA 0.3120400   0.5091943  1.631824     revenue
      2 2021-05-07 16:53:00      ADA 0.3125132   0.6266931  2.005333     revenue
      3 2021-05-12 16:56:00      ADA 0.2212410   0.4441940  2.007738     revenue
      4 2021-05-17 17:16:00      ADA 0.4123210   1.0798503  2.618955     revenue
      5 2021-05-17 21:16:00      ADA 0.1691870   0.4430932  2.618955        sell
      6 2021-05-17 21:31:00      ADA 0.1912300   0.5008228  2.618955        sell
           description        comment revenue.type exchange   rate.source
      1 Reward awarded           <NA>      staking  adalite coinmarketcap
      2 Reward awarded           <NA>      staking  adalite coinmarketcap
      3 Reward awarded           <NA>      staking  adalite coinmarketcap
      4 Reward awarded           <NA>      staking  adalite coinmarketcap
      5           Sent Withdrawal Fee         <NA>  adalite coinmarketcap
      6           Sent Withdrawal Fee         <NA>  adalite coinmarketcap

---

    Code
      format_detect(data_binance, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: binance
    Output
                        date currency   quantity     total.price   spot.rate
      1  2021-05-29 17:07:20      LTC 2.53200000  521.6626161494  206.027889
      2  2021-05-29 17:07:20      ETH 0.19521000  521.6626161494 2672.315026
      3  2021-05-29 17:07:20      LTC 2.41210000  496.9598722014  206.027889
      4  2021-05-29 17:07:20      ETH 0.14123140  496.9598722014 3518.763336
      5  2021-05-29 17:07:20      LTC 1.45120000  298.9876732054  206.027889
      6  2021-05-29 17:07:20      ETH 0.11240000  298.9876732054 2660.032680
      7  2021-05-29 17:07:20      LTC 1.42100000  292.7656309433  206.027889
      8  2021-05-29 17:07:20      ETH 0.10512900  292.7656309433 2784.822751
      9  2021-05-29 17:07:20      LTC 0.30000000   61.8083668423  206.027889
      10 2021-05-29 17:07:20      ETH 0.00899120   61.8083668423 6874.317871
      11 2021-05-29 17:07:20      LTC 0.27000000   55.6275301581  206.027889
      12 2021-05-29 17:07:20      ETH 0.00612410   55.6275301581 9083.380441
      13 2021-05-29 17:07:20      LTC 0.00202500    0.4172064762  206.027889
      14 2021-05-29 17:07:20      LTC 0.00127520    0.2627267647  206.027889
      15 2021-05-29 17:07:20      LTC 0.00113100    0.2330175430  206.027889
      16 2021-05-29 17:07:20      LTC 0.00049230    0.1014275300  206.027889
      17 2021-05-29 17:07:20      LTC 0.00007000    0.0144219523  206.027889
      18 2021-05-29 17:07:20      LTC 0.00005000    0.0103013945  206.027889
      19 2021-05-29 18:12:55      ETH 0.44124211 1250.5929350551 2834.255631
      20 2021-05-29 18:12:55      LTC 1.60000000 1250.5929350551  781.620584
      21 2021-05-29 18:12:55      ETH 0.42124000 1193.9018421488 2834.255631
      22 2021-05-29 18:12:55      LTC 1.23000000 1193.9018421488  970.651904
      23 2021-05-29 18:12:55      ETH 0.00021470    0.6085146841 2834.255631
      24 2021-05-29 18:12:55      ETH 0.00009251    0.2621969885 2834.255631
      25 2021-11-05 04:32:23     BUSD 0.10512330    0.1309574574    1.245751
      26 2022-11-17 11:54:25     ETHW 0.00012050    0.0006084561    5.049428
      27 2022-11-27 08:05:35     USDC 5.77124200    7.7366916521    1.340559
      28 2022-11-27 08:05:35     BUSD 5.77124200    7.7365241364    1.340530
         transaction       fees                   description comment revenue.type
      1          buy 1.52893297                           Buy    Spot         <NA>
      2         sell         NA                           Buy    Spot         <NA>
      3          buy 1.19743409                           Buy    Spot         <NA>
      4         sell         NA                           Buy    Spot         <NA>
      5          buy 1.11687719                           Buy    Spot         <NA>
      6         sell         NA                           Buy    Spot         <NA>
      7          buy 0.64342510                           Buy    Spot         <NA>
      8         sell         NA                           Buy    Spot         <NA>
      9          buy 0.06180837                           Buy    Spot         <NA>
      10        sell         NA                           Buy    Spot         <NA>
      11         buy 0.04326586                           Buy    Spot         <NA>
      12        sell         NA                           Buy    Spot         <NA>
      13     revenue         NA             Referral Kickback    Spot      rebates
      14     revenue         NA             Referral Kickback    Spot      rebates
      15     revenue         NA             Referral Kickback    Spot      rebates
      16     revenue         NA             Referral Kickback    Spot      rebates
      17     revenue         NA             Referral Kickback    Spot      rebates
      18     revenue         NA             Referral Kickback    Spot      rebates
      19         buy 6.01747615                          Sell    Spot         <NA>
      20        sell         NA                          Sell    Spot         <NA>
      21         buy 1.73569815                          Sell    Spot         <NA>
      22        sell         NA                          Sell    Spot         <NA>
      23     revenue         NA             Referral Kickback    Spot      rebates
      24     revenue         NA             Referral Kickback    Spot      rebates
      25     revenue         NA Simple Earn Flexible Interest    Earn    interests
      26     revenue         NA                  Distribution    Spot        forks
      27        sell         NA   Stablecoins Auto-Conversion    Spot         <NA>
      28         buy         NA   Stablecoins Auto-Conversion    Spot         <NA>
         exchange               rate.source
      1   binance             coinmarketcap
      2   binance coinmarketcap (buy price)
      3   binance             coinmarketcap
      4   binance coinmarketcap (buy price)
      5   binance             coinmarketcap
      6   binance coinmarketcap (buy price)
      7   binance             coinmarketcap
      8   binance coinmarketcap (buy price)
      9   binance             coinmarketcap
      10  binance coinmarketcap (buy price)
      11  binance             coinmarketcap
      12  binance coinmarketcap (buy price)
      13  binance             coinmarketcap
      14  binance             coinmarketcap
      15  binance             coinmarketcap
      16  binance             coinmarketcap
      17  binance             coinmarketcap
      18  binance             coinmarketcap
      19  binance             coinmarketcap
      20  binance coinmarketcap (buy price)
      21  binance             coinmarketcap
      22  binance coinmarketcap (buy price)
      23  binance             coinmarketcap
      24  binance             coinmarketcap
      25  binance             coinmarketcap
      26  binance             coinmarketcap
      27  binance             coinmarketcap
      28  binance             coinmarketcap

---

    Code
      format_detect(data_binance_withdrawals, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: binance_withdrawals
    Output
                       date currency quantity total.price spot.rate transaction
      1 2021-04-28 17:13:50      LTC 0.001000   0.3201871  320.1871        sell
      2 2021-04-28 18:15:14      ETH 0.000071   0.2373204 3342.5405        sell
      3 2021-05-06 19:55:52      ETH 0.000062   0.2656118 4284.0612        sell
            description exchange   rate.source
      1 Withdrawal fees  binance coinmarketcap
      2 Withdrawal fees  binance coinmarketcap
      3 Withdrawal fees  binance coinmarketcap

---

    Code
      format_detect(data_blockfi, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: blockfi
    Output
                       date currency     quantity total.price    spot.rate
      1 2021-05-29 21:43:44      LTC  0.022451200   4.6255734   206.027889
      2 2021-05-29 21:43:44      BTC  0.000018512   0.7858598 42451.369876
      3 2021-06-13 21:43:44      BTC  0.000184120   8.3556212 45381.388034
      4 2021-06-30 21:43:44      BTC  0.000047234   2.0770535 43973.694092
      5 2021-06-30 21:43:44      LTC  0.010125120   1.8084980   178.614968
      6 2021-07-29 21:43:44     USDC  0.038241000   0.0477449     1.248526
      7 2021-08-07 21:43:44      BTC  0.000441230  24.2005138 54847.843168
      8 2021-10-24 04:29:23     USDC 55.000000000  68.0777573     1.237777
      9 2021-10-24 04:29:23      LTC  0.165122140  68.0777573   412.287276
        transaction      description revenue.type exchange               rate.source
      1     revenue Interest Payment    interests  blockfi             coinmarketcap
      2     revenue Interest Payment    interests  blockfi             coinmarketcap
      3     revenue   Referral Bonus    referrals  blockfi             coinmarketcap
      4     revenue Interest Payment    interests  blockfi             coinmarketcap
      5     revenue Interest Payment    interests  blockfi             coinmarketcap
      6     revenue Interest Payment    interests  blockfi             coinmarketcap
      7     revenue    Bonus Payment       promos  blockfi             coinmarketcap
      8         buy            Trade         <NA>  blockfi             coinmarketcap
      9        sell            Trade         <NA>  blockfi coinmarketcap (buy price)

---

    Code
      format_detect(data_CDC_exchange_rewards, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: CDC_exchange_rewards
    Output
                        date currency   quantity  total.price     spot.rate
      1  2021-02-19 00:00:00      CRO 1.36512341 0.2227899953     0.1632014
      2  2021-02-21 00:00:00      CRO 1.36945123 0.2411195812     0.1760702
      3  2021-04-15 16:04:21      BTC 0.00000023 0.0182149274 79195.3367033
      4  2021-04-18 00:00:00      CRO 1.36512310 0.3798900187     0.2782826
      5  2021-05-14 06:02:22      BTC 0.00000035 0.0211513332 60432.3807116
      6  2021-06-12 15:21:34      BTC 0.00000630 0.2791139040 44303.7942802
      7  2021-06-27 01:34:00      CRO 0.00100000 0.0001239785     0.1239785
      8  2021-07-07 00:00:00      CRO 0.01512903 0.0022872188     0.1511808
      9  2021-07-13 00:00:00      CRO 0.05351230 0.0084128916     0.1572142
      10 2021-09-07 00:00:00      CRO 0.01521310 0.0035626681     0.2341842
         transaction description                                          comment
      1      revenue      Reward Interest on 5000.00000000 at 10% APR (Completed)
      2      revenue      Reward Interest on 5000.00000000 at 10% APR (Completed)
      3      revenue      Reward                          BTC Supercharger reward
      4      revenue      Reward Interest on 5000.00000000 at 10% APR (Completed)
      5      revenue      Reward                          BTC Supercharger reward
      6      revenue      Reward                          BTC Supercharger reward
      7         sell  Withdrawal                                             <NA>
      8      revenue      Reward                  Rebate on 0.18512341 CRO at 10%
      9      revenue      Reward                Rebate on 0.5231512346 CRO at 10%
      10     revenue      Reward                 Rebate on 0.155125123 CRO at 10%
         revenue.type     exchange   rate.source
      1     interests CDC.exchange coinmarketcap
      2     interests CDC.exchange coinmarketcap
      3     interests CDC.exchange coinmarketcap
      4     interests CDC.exchange coinmarketcap
      5     interests CDC.exchange coinmarketcap
      6     interests CDC.exchange coinmarketcap
      7          <NA> CDC.exchange coinmarketcap
      8       rebates CDC.exchange coinmarketcap
      9       rebates CDC.exchange coinmarketcap
      10      rebates CDC.exchange coinmarketcap

---

    Code
      format_detect(data_CDC_exchange_trades, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: CDC_exchange_trades
    Output
                        date currency   quantity total.price    spot.rate transaction
      1  2021-12-24 15:34:45      CRO 13260.1300 10386.66313    0.7833002         buy
      2  2021-12-24 15:34:45      ETH     2.0932 10386.66313 4962.0978083        sell
      3  2021-12-24 15:34:45      CRO  3555.9000  2785.33736    0.7833002         buy
      4  2021-12-24 15:34:45      ETH     0.5600  2785.33736 4973.8167068        sell
      5  2021-12-24 15:34:45      CRO  1781.7400  1395.63739    0.7833002         buy
      6  2021-12-24 15:34:45      ETH     0.2800  1395.63739 4984.4192352        sell
      7  2021-12-24 15:34:45      CRO    26.8500    21.03161    0.7833002         buy
      8  2021-12-24 15:34:45      ETH     0.0042    21.03161 5007.5265925        sell
      9  2021-12-24 15:34:45      CRO    26.6700    20.89062    0.7833002         buy
      10 2021-12-24 15:34:45      ETH     0.0042    20.89062 4973.9565819        sell
      11 2021-12-24 15:34:45      CRO    17.7800    13.92708    0.7833002         buy
      12 2021-12-24 15:34:45      CRO    17.7800    13.92708    0.7833002         buy
      13 2021-12-24 15:34:45      ETH     0.0028    13.92708 4973.9565819        sell
      14 2021-12-24 15:34:45      ETH     0.0028    13.92708 4973.9565819        sell
                fees description comment     exchange               rate.source
      1           NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      2  41.54665616        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      3           NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      4  11.14134692        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      5           NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      6   5.58256082        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      7           NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      8   0.08413730        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      9           NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      10  0.08355905        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      11          NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      12          NA         BUY ETH_CRO CDC.exchange             coinmarketcap
      13  0.05570691        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)
      14  0.05570683        SELL ETH_CRO CDC.exchange coinmarketcap (buy price)

---

    Code
      format_detect(data_CDC_wallet, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: CDC_wallet
    Output
                       date currency quantity   total.price spot.rate transaction
      1 2021-04-12 18:28:50      CRO 0.512510 0.13593610436 0.2652360     revenue
      2 2021-04-23 18:51:53      CRO 1.656708 0.36013687043 0.2173811     revenue
      3 2021-05-21 01:19:01      CRO 0.000200 0.00002993323 0.1496661        sell
      4 2021-06-26 14:51:02      CRO 6.051235 0.70769054418 0.1169498     revenue
        description                                            comment revenue.type
      1      Reward                         Auto Withdraw Reward from       staking
      2      Reward                         Auto Withdraw Reward from       staking
      3  Withdrawal Outgoing Transaction to abcdefghijklmnopqrstuvwxyz         <NA>
      4      Reward    Withdraw Reward from abcdefghijklmnopqrstuvwxyz      staking
          exchange   rate.source
      1 CDC.wallet coinmarketcap
      2 CDC.wallet coinmarketcap
      3 CDC.wallet coinmarketcap
      4 CDC.wallet coinmarketcap

---

    Code
      format_detect(data_coinsmart, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: coinsmart
    Output
                       date currency  quantity total.price    spot.rate transaction
      1 2021-04-25 16:11:24      ADA 198.50000 237.9374300     1.198677         buy
      2 2021-04-28 18:37:15      CAD  15.00000  15.0000000     1.000000     revenue
      3 2021-05-15 16:42:07      BTC   0.00004   2.3397033 58492.582640     revenue
      4 2021-06-03 02:04:49      ADA   0.30000   0.6512228     2.170743        sell
            fees description  comment revenue.type  exchange   rate.source
      1 0.269386    purchase    Trade         <NA> coinsmart      exchange
      2       NA       Other Referral    referrals coinsmart      exchange
      3       NA       Other     Quiz     airdrops coinsmart coinmarketcap
      4       NA         Fee Withdraw         <NA> coinsmart coinmarketcap

---

    Code
      format_detect(data_exodus, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: exodus
    Output
                       date currency  quantity total.price    spot.rate transaction
      1 2021-05-25 22:06:11      LTC 0.0014430   0.3206295   222.196455        sell
      2 2021-05-25 23:08:12      ADA 0.1782410   0.3337586     1.872513        sell
      3 2021-06-12 12:15:28      BTC 0.0000503   2.2284809 44303.794280        sell
      4 2021-06-12 22:31:35      ETH 0.0014500   4.1661267  2873.190813        sell
        description revenue.type exchange   rate.source
      1  withdrawal         <NA>   exodus coinmarketcap
      2  withdrawal         <NA>   exodus coinmarketcap
      3  withdrawal         <NA>   exodus coinmarketcap
      4  withdrawal         <NA>   exodus coinmarketcap

---

    Code
      format_detect(data_presearch, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: presearch
    Output
                        date currency quantity total.price  spot.rate transaction
      1  2021-04-27 17:45:18      PRE     0.13  0.01209844 0.09306492     revenue
      2  2021-04-27 17:48:00      PRE     0.13  0.01209844 0.09306492     revenue
      3  2021-04-27 17:48:18      PRE     0.13  0.01209844 0.09306492     revenue
      4  2021-04-27 17:55:24      PRE     0.13  0.01209844 0.09306492     revenue
      5  2021-04-27 17:57:29      PRE     0.13  0.01209844 0.09306492     revenue
      6  2021-04-27 19:00:31      PRE     0.13  0.01209844 0.09306492     revenue
      7  2021-04-27 19:00:41      PRE     0.13  0.01209844 0.09306492     revenue
      8  2021-04-27 19:01:57      PRE     0.13  0.01209844 0.09306492     revenue
      9  2021-04-27 19:08:59      PRE     0.13  0.01209844 0.09306492     revenue
      10 2021-04-27 19:12:15      PRE     0.13  0.01209844 0.09306492     revenue
      11 2021-05-07 05:55:33      PRE  1000.00 78.90639103 0.07890639         buy
                                             description revenue.type  exchange
      1                                    Search Reward     airdrops presearch
      2                                    Search Reward     airdrops presearch
      3                                    Search Reward     airdrops presearch
      4                                    Search Reward     airdrops presearch
      5                                    Search Reward     airdrops presearch
      6                                    Search Reward     airdrops presearch
      7                                    Search Reward     airdrops presearch
      8                                    Search Reward     airdrops presearch
      9                                    Search Reward     airdrops presearch
      10                                   Search Reward     airdrops presearch
      11 Transferred from Presearch Portal (PO#: 412893)         <NA> presearch
           rate.source
      1  coinmarketcap
      2  coinmarketcap
      3  coinmarketcap
      4  coinmarketcap
      5  coinmarketcap
      6  coinmarketcap
      7  coinmarketcap
      8  coinmarketcap
      9  coinmarketcap
      10 coinmarketcap
      11 coinmarketcap

---

    Code
      format_detect(data_gemini, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: gemini
    Output
                        date currency        quantity total.price     spot.rate
      1  2021-04-09 22:50:55      BTC  0.000966278356  70.6618968 73127.8895000
      2  2021-04-09 22:50:55      LTC  0.246690598398  70.6618968   286.4393588
      3  2021-04-09 22:53:57      BTC  0.000006051912   0.4425635 73127.8895000
      4  2021-04-09 22:53:57      LTC  0.001640820000   0.4425635   269.7209419
      5  2021-04-09 23:20:53      BAT 48.719519585106  86.3881744     1.7731738
      6  2021-04-09 23:20:53      BTC  0.000950730015  86.3881744 90865.0963117
      7  2021-04-10 23:22:04      BTC  0.000285025578  21.0788079 73954.0922149
      8  2021-05-08 16:14:54      BAT  2.833934780210   4.8581158     1.7142652
      9  2021-05-16 12:55:02      BAT  3.085288331282   4.2582521     1.3801796
      10 2021-05-16 13:35:19      BAT  5.007481461482   6.9112238     1.3801796
      11 2021-06-18 01:38:54      BAT  6.834322542857   5.3875147     0.7883027
         transaction            fees description               comment revenue.type
      1          buy 0.0000023034086      LTCBTC                Market         <NA>
      2         sell              NA      LTCBTC                Market         <NA>
      3          buy 0.0000000365181      LTCBTC                 Limit         <NA>
      4         sell              NA      LTCBTC                 Limit         <NA>
      5          buy              NA      BATBTC                 Limit         <NA>
      6         sell 0.0000018142411      BATBTC                 Limit         <NA>
      7      revenue              NA      Credit Administrative Credit    referrals
      8      revenue              NA      Credit Administrative Credit    referrals
      9      revenue              NA      Credit               Deposit     airdrops
      10     revenue              NA      Credit               Deposit     airdrops
      11     revenue              NA      Credit               Deposit     airdrops
         exchange               rate.source
      1    gemini             coinmarketcap
      2    gemini coinmarketcap (buy price)
      3    gemini             coinmarketcap
      4    gemini coinmarketcap (buy price)
      5    gemini             coinmarketcap
      6    gemini coinmarketcap (buy price)
      7    gemini             coinmarketcap
      8    gemini             coinmarketcap
      9    gemini             coinmarketcap
      10   gemini             coinmarketcap
      11   gemini             coinmarketcap

---

    Code
      format_detect(data_uphold, list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: uphold
    Output
                        date currency    quantity total.price   spot.rate transaction
      1  2021-01-07 02:40:31      BAT  1.59081275   0.5114264   0.3214875     revenue
      2  2021-02-09 14:26:49      BAT 12.69812163   6.8805827   0.5418583     revenue
      3  2021-03-06 21:32:36      BAT  0.37591275   0.3203871   0.8522910     revenue
      4  2021-03-07 21:46:57      LTC  0.24129740  57.0095475 236.2625850         buy
      5  2021-03-07 21:46:57      BAT 52.59871206  57.0095475   1.0838582        sell
      6  2021-03-07 21:54:09      LTC  0.00300000   0.7087878 236.2625850        sell
      7  2021-04-05 12:22:00      BAT  8.52198415  13.2125179   1.5504039     revenue
      8  2021-04-06 03:41:42      LTC  0.00300000   0.8643769 288.1256316        sell
      9  2021-04-06 04:47:00      LTC  0.03605981  10.3897561 288.1256316         buy
      10 2021-04-06 04:47:00      BAT  8.52198415  10.3897561   1.2191710        sell
      11 2021-05-11 07:12:24      BAT  0.47521985   0.7777261   1.6365606     revenue
      12 2021-06-09 04:52:23      BAT  0.67207415   0.5586404   0.8312183     revenue
         description         comment revenue.type exchange               rate.source
      1           in            <NA>     airdrops   uphold             coinmarketcap
      2           in            <NA>     airdrops   uphold             coinmarketcap
      3           in            <NA>     airdrops   uphold             coinmarketcap
      4        trade         BAT-LTC         <NA>   uphold             coinmarketcap
      5        trade         BAT-LTC         <NA>   uphold coinmarketcap (buy price)
      6          out withdrawal fees         <NA>   uphold             coinmarketcap
      7           in            <NA>     airdrops   uphold             coinmarketcap
      8          out withdrawal fees         <NA>   uphold             coinmarketcap
      9        trade         BAT-LTC         <NA>   uphold             coinmarketcap
      10       trade         BAT-LTC         <NA>   uphold coinmarketcap (buy price)
      11          in            <NA>     airdrops   uphold             coinmarketcap
      12          in            <NA>     airdrops   uphold             coinmarketcap

# format_detect list

    Code
      format_detect(list(data_shakepay, data_newton, data_adalite), list.prices = list.prices)
    Message <simpleMessage>
      Exchange detected: shakepay
      Exchange detected: newton
      Exchange detected: adalite
    Output
                        date currency    quantity  total.price    spot.rate
      1  2021-04-04 22:50:12      LTC  0.10482910   23.4912731   224.091146
      2  2021-04-04 22:53:46      CAD 25.00000000   25.0000000     1.000000
      3  2021-04-04 22:55:55      ETH  2.71987120 3423.8221510  1258.817752
      4  2021-04-21 19:57:26      BTC  0.00343000  153.1241354 44642.605073
      5  2021-04-28 16:56:00      ADA  0.31204000    0.5091943     1.631824
      6  2021-05-07 14:50:41      BTC  0.00103982   53.0333500 51002.433113
      7  2021-05-07 16:53:00      ADA  0.31251320    0.6266931     2.005333
      8  2021-05-07 21:25:36      CAD 30.00000000   30.0000000     1.000000
      9  2021-05-08 12:12:57      BTC  0.00011000    5.7840236 52582.032400
      10 2021-05-09 12:22:07      BTC  0.00012000    6.0344409 50287.007900
      11 2021-05-12 16:56:00      ADA  0.22124100    0.4441940     2.007738
      12 2021-05-12 21:37:42      BTC  0.00000400    0.3049013 76225.317500
      13 2021-05-12 21:52:40      BTC  0.00321300  156.1241341 48591.389386
      14 2021-05-17 17:16:00      ADA  0.41232100    1.0798503     2.618955
      15 2021-05-17 21:16:00      ADA  0.16918700    0.4430932     2.618955
      16 2021-05-17 21:31:00      ADA  0.19123000    0.5008228     2.618955
      17 2021-05-21 12:47:14      BTC  0.00013000    7.3485904 56527.618800
      18 2021-06-11 12:03:31      BTC  0.00014000    8.3969267 59978.047700
      19 2021-06-16 18:49:11      CAD 25.00000000   25.0000000     1.000000
      20 2021-06-23 12:21:49      BTC  0.00015000    8.7148765 58099.177000
      21 2021-07-10 00:52:19      BTC  0.00052991   31.2684800 59007.152158
         transaction      description        comment revenue.type exchange
      1          buy            TRADE           <NA>         <NA>   newton
      2      revenue Referral Program           <NA>    referrals   newton
      3          buy            TRADE           <NA>         <NA>   newton
      4          buy            TRADE           <NA>         <NA>   newton
      5      revenue   Reward awarded           <NA>      staking  adalite
      6          buy    purchase/sale       purchase         <NA> shakepay
      7      revenue   Reward awarded           <NA>      staking  adalite
      8      revenue            other         credit    referrals shakepay
      9      revenue      shakingsats         credit     airdrops shakepay
      10     revenue      shakingsats         credit     airdrops shakepay
      11     revenue   Reward awarded           <NA>      staking  adalite
      12         buy            TRADE           <NA>         <NA>   newton
      13        sell            TRADE           <NA>         <NA>   newton
      14     revenue   Reward awarded           <NA>      staking  adalite
      15        sell             Sent Withdrawal Fee         <NA>  adalite
      16        sell             Sent Withdrawal Fee         <NA>  adalite
      17     revenue      shakingsats         credit     airdrops shakepay
      18     revenue      shakingsats         credit     airdrops shakepay
      19     revenue Referral Program           <NA>    referrals   newton
      20     revenue      shakingsats         credit     airdrops shakepay
      21        sell    purchase/sale           sale         <NA> shakepay
           rate.source
      1       exchange
      2       exchange
      3       exchange
      4       exchange
      5  coinmarketcap
      6       exchange
      7  coinmarketcap
      8       exchange
      9       exchange
      10      exchange
      11 coinmarketcap
      12      exchange
      13      exchange
      14 coinmarketcap
      15 coinmarketcap
      16 coinmarketcap
      17      exchange
      18      exchange
      19      exchange
      20      exchange
      21      exchange

