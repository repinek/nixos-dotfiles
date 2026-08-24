local home = assert(os.getenv("HOME"), "HOME is not set")

local screenshot_dir = home .. "/Media/Screenshots/$(date +%Y-%m)"
local screenshot_name = "Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
local mkdir_screenshot = "mkdir -p " .. screenshot_dir

return {
    main_mod = "SUPER",

    file_manager = "nemo",
    terminal = "alacritty",
    browser = "waterfox",

    hyprpicker = "hyprpicker --autocopy --no-fancy --render-inactive --scale=8",
    hyprshot_region = mkdir_screenshot
        .. " && hyprshot --freeze --mode region --output-folder "
        .. screenshot_dir
        .. " --filename "
        .. screenshot_name,
    hyprshot_satty = mkdir_screenshot
        .. " && hyprshot --freeze --mode region --raw | satty --filename - --output-filename "
        .. screenshot_dir
        .. "/"
        .. screenshot_name,
    hyprshot_full = mkdir_screenshot
        .. " && hyprshot --freeze --mode output --mode active --output-folder "
        .. screenshot_dir
        .. " --filename "
        .. screenshot_name,
}
