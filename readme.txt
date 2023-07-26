=== Block Library ===
Contributors: Roberto Di Marco
Tags: gutenberg, blocks, custom blocks
Tested up to: 6.1
Stable tag: 1.0.0
License: GPL-2.0-or-later
License URI: https://www.gnu.org/licenses/gpl-2.0.html

A WordPress plugin that provides an efficient system for developers to create and manage custom blocks and patterns for the Gutenberg editor.

== Description ==

The Block Library plugin is designed to consolidate the development of custom blocks and patterns into one single plugin. This makes it easier for developers to create complex and unique page layouts in the Gutenberg editor.

Key features include:

A library of custom blocks addressing a variety of design and functionality needs.
A custom block category, 'Block Library', for organizing custom blocks within the Gutenberg editor.
A bash script for automating the creation of new custom blocks.
A bash script for automating the removal of custom blocks.
A bash script for automating the creation of new custom patterns.
A bash script for automating the removal of custom patterns.
== Installation ==

Ensure you have Node.js and npm installed on your machine.
Run npm install in the main directory of the plugin to install all project dependencies.
Make the block creation script executable by running chmod +x create-block.sh in the main directory of the plugin.
Make the block removal script executable by running chmod +x remove-block.sh in the main directory of the plugin.
Make the pattern creation script executable by running chmod +x create-pattern.sh in the main directory of the plugin.
Make the pattern removal script executable by running chmod +x remove-pattern.sh in the main directory of the plugin.
== Usage ==

The npm run build command can be used to perform a global build of the blocks, or the npm run build:<block-name> command can be used to perform a build for a single block.

To create a new block, run ./create-block.sh "<block-name>" replacing <block-name> with the name of the new block you want to create.

To remove a block, run ./remove-block.sh "<block-name>" replacing <block-name> with the name of the block you want to remove.

To create a new pattern, run ./create-pattern.sh "<pattern-name>" replacing <pattern-name> with the name of the new pattern you want to create.

To remove a pattern, run ./remove-pattern.sh "<pattern-name>" replacing <pattern-name> with the name of the pattern you want to remove.

== Changelog ==

= 1.0.0 =

Initial release.