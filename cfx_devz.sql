ALTER TABLE `owned_vehicles` ADD `status` text(65535) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci' ;INSERT INTO `items`
            ( 
                        `NAME`, 
                        `label`, 
                        `limit` 
            ) 
            VALUES 
            ( 
                        'packaged_main_kit', 
                        'Packaged Maintenance kit', 
                        2 
            ) 
            , 
            ( 
                        'scrap_fuel_tank', 
                        'Scrap Fuel Tank Patches', 
                        5 
            ) 
            , 
            ( 
                        'scrap_radiator', 
                        'Scrap Radiator', 
                        5 
            ) 
            , 
            ( 
                        'scrap_clutch', 
                        'Scrap Clutch', 
                        5 
            ) 
            , 
            ( 
                        'scrap_brakes', 
                        'Scrap Brakes', 
                        5 
            ) 
            , 
            ( 
                        'scrap_axle', 
                        'Scrap Axle', 
                        5 
            ) 
            , 
            ( 
                        'fuel_tank', 
                        'Fuel Tank Patches', 
                        5 
            ) 
            , 
            ( 
                        'radiator', 
                        'Radiator', 
                        5 
            ) 
            , 
            ( 
                        'clutch', 
                        'Clutch', 
                        5 
            ) 
            , 
            ( 
                        'brakes', 
                        'Brakes', 
                        5 
            ) 
            , 
            ( 
                        'axle', 
                        'Axle', 
                        5 
            ) ;