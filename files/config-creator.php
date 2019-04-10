#!/usr/bin/env php
<?php
/**
 * Creates Config file based on environment variables
 * Author: Artur Oliveira
 * E-mail: artur@arturluiz.com.br | contato@arturluiz.com
 * Date: 09/04/1991
 */


# Sorts enviroment variables based on regex
$config = [];
foreach($_ENV as $k => $v) {
    # Defines suffix of enviroment variables used in this script
    $suffix = 'PKP';

    # Uses the second part of enviroment variable name as category
    if(preg_match("/^$suffix\_([0-9A-Za-z]+)\_(.+)$/", $k, $m)===1) {
        $m = array_map(function($v) {
            return strtolower($v);
        }, $m);
        $config[$m[1]][$m[2]] = $v;
    }
}

# Creates config template based on sorted enviroment variable
$config_text = <<<CONFIG
<?php exit(); // DO NOT DELETE ?>\n\n
CONFIG;

foreach($config as $group => $params) {
    $config_text .= "[$group]\n";
    foreach($params as $param => $value) {
        $config_text .= "$param=$value\n";
    }
    $config_text .= "\n";
}

print($config_text);