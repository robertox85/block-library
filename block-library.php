<?php

/**
 * Plugin Name:       Block Library
 * Description:       Un plugin WordPress che fornisce una serie di blocchi personalizzati per l'editor Gutenberg.
 * Requires at least: 6.1
 * Requires PHP:      7.0
 * Version:           0.1.0
 * Author:            Roberto Di Marco
 * License:           GPL-2.0-or-later
 * License URI:       https://www.gnu.org/licenses/gpl-2.0.html
 * Text Domain:       block-library
 *
 * @package           block-library
 */

add_filter('block_categories_all', 'new_block_category');
add_action('admin_menu', 'create_block_block_library_options_page');
add_action('admin_init', 'create_block_block_library_settings_init');
add_action('init', 'block_library_init');
add_action('admin_enqueue_scripts', 'block_library_assets_init');

function block_library_init()
{
    register_custom_block_pattern_category();
    register_custom_block_patterns();
    create_block_block_library_block_init();
    create_block_block_library_pattern_init();
}

function block_library_assets_init($hook)
{
    block_library_add_admin_scripts($hook);
    block_library_add_admin_styles($hook);
}

function new_block_category($cats)
{
    $new = array(
        'slug'  => 'block-library',
        'title' => 'block Library',
    );

    array_unshift($cats, $new);

    return $cats;
}

function create_block_block_library_options_page()
{
    add_options_page(
        'Block Library Options',
        'Block Library',
        'manage_options',
        'block-library',
        'create_block_block_library_options_page_html'
    );
}


function create_block_block_library_options_page_html()
{
    if (!current_user_can('manage_options')) {
        return;
    }
?>
    <div class="wrap">
        <h1><?= esc_html(get_admin_page_title()); ?></h1>
        <form action="options.php" method="post">
            <p>
                <label>
                    <input type="checkbox" id="select-all">
                    Seleziona/Deseleziona tutti
                </label>
            </p>
            <?php
            settings_fields('block_library_options');
            do_settings_sections('block_library_options');
            submit_button('Save Settings');
            ?>
        </form>
    </div>
<?php
}

function create_block_block_library_settings_init()
{
    register_setting('block_library_options', 'block_library_block_settings');
    register_setting('block_library_options', 'block_library_pattern_settings');

    $blocks = glob(plugin_dir_path(__FILE__) . 'blocks/*', GLOB_ONLYDIR);

    add_settings_section(
        'block_library_block_settings_section',
        'Block Settings',
        null,
        'block_library_options'
    );

    foreach ($blocks as $block) {
        $block_name = basename($block);

        add_settings_field(
            $block_name,
            $block_name,
            'create_block_block_library_settings_field_cb',
            'block_library_options',
            'block_library_block_settings_section',
            [
                'label_for' => $block_name,
                'class' => 'block_library_row',
                'block_library_custom_data' => 'custom',
            ]
        );
    }

    add_settings_section(
        'block_library_pattern_settings_section',
        'Pattern Settings',
        null,
        'block_library_options'
    );

    $patterns = glob(plugin_dir_path(__FILE__) . 'patterns/*', GLOB_ONLYDIR);
    foreach ($patterns as $pattern) {
        $pattern_name = basename($pattern);

        add_settings_field(
            $pattern_name,
            $pattern_name,
            'create_block_block_library_pattern_settings_field_cb',
            'block_library_options',
            'block_library_pattern_settings_section',
            [
                'label_for' => $pattern_name,
                'class' => 'block_library_row',
                'block_library_custom_data' => 'custom',
            ]
        );
    }
}

function create_block_block_library_pattern_init()
{
    $patterns = glob(plugin_dir_path(__FILE__) . 'patterns/*', GLOB_ONLYDIR);
    $options = get_option('block_library_pattern_settings');

    // if options doesn't exist, create the default settings
    if ($options === false) {
        $options = array_fill_keys(array_map('basename', $patterns), 1);
        update_option('block_library_pattern_settings', $options);
    }

    foreach ($patterns as $pattern) {
        $pattern_name = basename($pattern);
        if (isset($options[$pattern_name]) && $options[$pattern_name]) {
            $pattern_properties = include $pattern . '/index.php';
            register_block_pattern($pattern_name, $pattern_properties);
        }
    }
}

function create_block_block_library_settings_field_cb($args)
{
    $options = get_option('block_library_block_settings');
    $checked = isset($options[$args['label_for']]) && $options[$args['label_for']];
?>
    <input type="checkbox" id="<?= esc_attr($args['label_for']); ?>" name="block_library_block_settings[<?= esc_attr($args['label_for']); ?>]" <?php checked($checked, 1); ?> value="1">
<?php
}

function create_block_block_library_block_init()
{
    $blocks = glob(plugin_dir_path(__FILE__) . 'blocks/*', GLOB_ONLYDIR);
    $options = get_option('block_library_block_settings');
    
    // if options doesn't exist, create the default settings
    if ($options === false) {
        $options = array_fill_keys(array_map('basename', $blocks), 1);
        update_option('block_library_block_settings', $options);
    }

    foreach ($blocks as $block) {
        $block_name = basename($block);
        if (isset($options[$block_name]) && $options[$block_name]) {
            register_block_type(plugin_dir_path(__FILE__) . 'blocks/' . $block_name . '/build');
        }
    }
}

function create_block_block_library_pattern_settings_field_cb($args)
{
    $options = get_option('block_library_pattern_settings');
    $checked = isset($options[$args['label_for']]) && $options[$args['label_for']];
?>
    <input type="checkbox" id="<?= esc_attr($args['label_for']); ?>" name="block_library_pattern_settings[<?= esc_attr($args['label_for']); ?>]" <?php checked($checked, 1); ?> value="1">
<?php
}

function block_library_add_admin_scripts($hook)
{
    if ($hook != 'settings_page_block-library') {
        return;
    }
    wp_enqueue_script('block-library-admin', plugins_url('admin.js', __FILE__), array('jquery'), '1.0.0', true);
}

function block_library_add_admin_styles($hook)
{
    if (strpos($hook, 'post.php') === false && strpos($hook, 'post-new.php') === false) {
        return;
    }
    wp_enqueue_style('block-library-admin', plugins_url('admin.css', __FILE__));
}

function register_custom_block_patterns()
{
    if (function_exists('register_block_pattern')) {
        $options = get_option('block_library_pattern_settings', []);
        $patterns = glob(plugin_dir_path(__FILE__) . 'patterns/*', GLOB_ONLYDIR);
        foreach ($patterns as $pattern) {
            $pattern_name = basename($pattern);
            if (isset($options[$pattern_name]) && $options[$pattern_name]) {
                $pattern_properties = include $pattern . '/index.php';
                register_block_pattern($pattern_name, $pattern_properties);
            }
        }
    }
}

function register_custom_block_pattern_category()
{
    if (function_exists('register_block_pattern_category')) {
        register_block_pattern_category('block-library', array('label' => __('Block Library')));
    }
}

