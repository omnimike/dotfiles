-- Look and feel configuration

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 8,
        border_size = 2,
        extend_border_grab_area = 10,
        resize_on_border = true,
        col = {
            active_border = {
                colors = { YELLOW },
                angle = 45,
            },
            inactive_border = BLACK,
        },
    },
    group = {
        col = {
            border_active = YELLOW,
            border_inactive = BLACK,
            border_locked_active = BLUE,
            border_locked_inactive = BLACK,
        },
        groupbar = {
            col = {
                active = YELLOW,
                inactive = BLACK,
                locked_active = BLUE,
                locked_inactive = BLACK,
            },
        },
    },
    decoration = {
        dim_special = 0.3,
        rounding = 10,
        active_opacity = 0.95,
        inactive_opacity = 0.85,
        fullscreen_opacity = 1,
        blur = {
            size = 5,
            passes = 4,
            special = true,
        },
    },
})
