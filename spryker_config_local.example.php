<?php

use Spryker\Shared\Application\ApplicationConstants;
use Spryker\Shared\Propel\PropelConstants;
use Spryker\Shared\RabbitMq\RabbitMqConstants;
use Spryker\Shared\Search\SearchConstants;
use Spryker\Shared\Session\SessionConstants;
use Spryker\Shared\Setup\SetupConstants;
use Spryker\Shared\Storage\StorageConstants;
use Spryker\Shared\ZedRequest\ZedRequestConstants;

$config[PropelConstants::USE_SUDO_TO_MANAGE_DATABASE] = false;

$config[SearchConstants::ELASTICA_PARAMETER__HOST] = 'elasticsearch';
$config[SearchConstants::ELASTICA_PARAMETER__PORT] = 9200;


$config[PropelConstants::ZED_DB_HOST] = 'database';
$config[PropelConstants::ZED_DB_USERNAME] = 'development';
$config[PropelConstants::ZED_DB_PASSWORD] = 'mate20mg';
$config[PropelConstants::ZED_DB_PORT] = 5432;

$config[StorageConstants::STORAGE_REDIS_HOST] = 'redis';
$config[StorageConstants::STORAGE_REDIS_PORT] = '6379';
$config[SessionConstants::YVES_SESSION_REDIS_HOST] = $config[StorageConstants::STORAGE_REDIS_HOST];
$config[SessionConstants::YVES_SESSION_REDIS_PORT] = $config[StorageConstants::STORAGE_REDIS_PORT];
$config[SessionConstants::ZED_SESSION_REDIS_HOST] = $config[StorageConstants::STORAGE_REDIS_HOST];
$config[SessionConstants::ZED_SESSION_REDIS_PORT] = $config[StorageConstants::STORAGE_REDIS_PORT];

$config[RabbitMqConstants::RABBITMQ_HOST] = 'rabbitmq';
$config[RabbitMqConstants::RABBITMQ_PORT] = '5672';
$config[RabbitMqConstants::RABBITMQ_PASSWORD] = 'mate20mg';

$config[RabbitMqConstants::RABBITMQ_API_HOST] = 'rabbitmq';
$config[RabbitMqConstants::RABBITMQ_API_PORT] = '15672';
$config[RabbitMqConstants::RABBITMQ_API_USERNAME] = 'admin';
$config[RabbitMqConstants::RABBITMQ_API_PASSWORD] = 'mate20mg';

$config[SetupConstants::JENKINS_BASE_URL] = 'http://jenkins:8080/';
$config[SetupConstants::JENKINS_DIRECTORY] = '/data/shop/development/shared/data/common/jenkins';