
Config = {}

Config.CollectionPoints = {
    vector3(-2532.76, 2808.70, 1.19),
    vector3(-2541.93, 2813.99, 2.78),
    vector3(-2546.77, 2822.07, 2.84),
    vector3(-2554.52, 2823.65, 2.86),
    vector3(-2563.46, 2808.67, 1.57),
    vector3(-2569.99, 2797.30, 0.11),
    vector3(-2563.07, 2782.33, 2.57),
    vector3(-2547.03, 2777.25, 3.09),
    vector3(-2538.59, 2768.48, 2.98),
    vector3(-2541.91, 2760.98, 2.83),
    vector3(-2537.10, 2749.11, 2.80),
    vector3(-2525.02, 2750.11, 2.77),
    vector3(-2508.98, 2751.38, 3.25),
    vector3(-2490.25, 2766.81, 2.87),
    vector3(-2489.63, 2785.30, 0.28),
    vector3(-2483.12, 2800.19, 2.05),
    vector3(-2474.09, 2801.62, 2.47),
    vector3(-2463.59, 2799.04, 2.64),
    vector3(-2462.02, 2787.37, 1.44),
    vector3(-2461.94, 2779.79, 0.23),
    vector3(-2464.18, 2772.53, 1.74),

    vector3(-2503.8655, 2769.8442, 2.8779),
    vector3(-2475.1909, 2741.8171, 2.8911),
    vector3(-2476.3586, 2764.9089, 3.0219),
    vector3(-2475.1367, 2783.5317, 0.5764),
    vector3(-2494.6077, 2813.4106, 3.1792),
    vector3(-2502.1550, 2812.8301, 3.0182),
    vector3(-2511.1941, 2805.6858, 2.9083),
    vector3(-2523.1169, 2817.8523, 1.5506),
    vector3(-2512.2329, 2829.6826, 3.2833),


    vector3(-2521.7695, 2763.4377, 1.5786)
}


Config.ProcessingLocation = vector4(-3425.18, 973.56, 8.35, 85.0)
Config.SellingLocation = vector4(-2953.44, 49.26, 11.61, 320.0)


Config.Items = {
    Shrimp = "shrimp",
    Crab = "crab",
    PackedShrimp = "packed_shrimp",
    PackedCrab = "packed_crab"
}


Config.Prices = {
    PackedShrimp = 700,
    PackedCrab = 500
}


Config.Blips = {
    PickupBlip = {coords = vector3(-2519.4761, 2789.6694, 1.1375), sprite = 751, color = 3, label = "Shrimp & Crab Pickup"},
    Processing = {coords = vector3(-3425.18, 973.56, 8.35), sprite = 356, color = 5, label = "Seafood Processing"},
    Selling = {coords = vector3(-2953.44, 49.26, 11.61), sprite = 434, color = 2, label = "Seafood Buyer"}
}

Config.CollectDuration = 10000
Config.PackDuration = 10000
Config.SellDuration = 10000



Config.MarkerCooldown = 10
