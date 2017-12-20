# Graphouse docker image

Graphouse allows you to use ClickHouse as a Graphite storage.

[github](https://github.com/yandex/graphouse)


Overview
--------

Graphouse provides:
- TCP server to receive metrics with [Graphite plaintext protocol](http://graphite.readthedocs.io/en/latest/feeding-carbon.html#the-plaintext-protocol).
- HTTP API for metric search and data retrieval (with graphite-web python module).
- HTTP API for metric tree management.

Comparing Graphouse with [common Graphite architecture](https://github.com/graphite-project/graphite-web#overview).


![arch_overview](https://github.com/yandex/graphouse/raw/master/doc/img/arch_overview.png)

Contacts
--------
If you have any questions, feel free to join our Telegram chat
https://t.me/graphouse


## Supported environment options

### Docker specific
-------------------

* DEBUG
* GH_CLICKHOUSE_USE_GRAPHITE_ENGINE (default: TRUE)

If `TRUE` create `graphite.data` with ENGINE: `GraphiteMergeTree(date, (metric, timestamp), 8192, 'graphite_rollup')`
Else create table with ENGINE: `ReplacingMergeTree(date, (metric, timestamp), 8192, updated)`


### Graphouse vmoptions
-----------------------

* `GH_XMS` (default 256m)
* `GH_XMX` (default 4g)
* `GH_XSS` (default 2m)

### Graphouse properties
------------------------

* `GH__ALLOW_COLD_RUN` (original: graphouse.allow-cold-run | defaul=false)

#### Clickhouse

* `GH__CLICKHOUSE__HOST` (original: graphouse.clickhouse.host | defaul=localhost)
* `GH__CLICKHOUSE__PORT` (original: graphouse.clickhouse.port | defaul=8123)
* `GH__CLICKHOUSE__DB` (original: graphouse.clickhouse.db | defaul=graphite)
* `GH__CLICKHOUSE__USER` (original: graphouse.clickhouse.user | defaul=)
* `GH__CLICKHOUSE__PASSWORD` (original: graphouse.clickhouse.password | defaul=)

* `GH__CLICKHOUSE__DATA_TABLE` (original: graphouse.clickhouse.data-table | defaul=data)
* `GH__CLICKHOUSE__METRIC_TREE_TABLE` (original: graphouse.clickhouse.metric-tree-table | defaul=metrics)

* `GH__CLICKHOUSE__SOCKET_TIMEOUT_SECONDS` (original: graphouse.clickhouse.socket-timeout-seconds | defaul=600)
* `GH__CLICKHOUSE__QUERY_TIMEOUT_SECONDS` (original: graphouse.clickhouse.query-timeout-seconds | defaul=120)

* `GH__CLICKHOUSE__RETENTION_CONFIG` (original: graphouse.clickhouse.retention-config | defaul=)
  > значение названия конфига из таблицы в КХ, например `graphite_rollup`. Посмотреть: `SELECT * FROM system.graphite_retentions`

#### metric server and cacher

* `GH__CACHER__BIND_ADDRESS` (original: graphouse.cacher.bind-address | default=::}
* `GH__CACHER__PORT` (original: graphouse.cacher.port | defaul=2003)
* `GH__CACHER__THREADS` (original: graphouse.cacher.threads | defaul=100)
* `GH__CACHER__SOCKET_TIMEOUT_MILLIS` (original: graphouse.cacher.socket-timeout-millis | defaul=42000)

* `GH__CACHER__QUEUE_SIZE` (original: graphouse.cacher.queue-size | default=10000000)
* `GH__CACHER__READ_BATCH_SIZE` (original: graphouse.cacher.read-batch-size | default=1000)
* `GH__CACHER__MIN_BATCH_SIZE` (original: graphouse.cacher.min-batch-size | default=10000)
* `GH__CACHER__MAX_BATCH_SIZE` (original: graphouse.cacher.max-batch-size | default=1000000)
* `GH__CACHER__MIN_BATCH_TIME_SECONDS` (original: graphouse.cacher.min-batch-time-seconds | default=1)
* `GH__CACHER__MAX_BATCH_TIME_SECONDS` (original: graphouse.cacher.max-batch-time-seconds | default=5)
* `GH__CACHER__MAX_OUTPUT_THREADS` (original: graphouse.cacher.max-output-threads | default=5)

##### Http server (metric search, ping, metricData)

* `GH__HTTP__PORT` (original: graphouse.http.port | defaul=2005)
* `GH__HTTP__THREADS` (original: graphouse.http.threads | defaul=25)

##### Mretric search and tree

* `GH__SEARCH__REFRESH_SECONDS` (original: graphouse.search.refresh-seconds | defaul=60)
* `GH__TREE__IN_MOMORY_LEVELS` (original: graphouse.tree.in-memory-levels | defaul=3)
  > Сколько уровней дерева метрик графаус будет на старте загружать в память.
  Остальные будут грузится только on-demang при запросах
* `GH__TREE__DIR_CONTENT__CACHE_TIME_MINUTES` (original: graphouse.tree.dir-content.cache-time-minutes | defaul=60)
* `GH__TREE__DIR_CONTENT__CACHE_CONCURRENCY_LEVELS` (original: graphouse.tree.dir-content.cache-concurrency-level | defaul=6)
* `GH__TREE__DIR_CONTENT__BATCHER__MAX_PARALLEL_REQUEST` (original: graphouse.tree.dir-content.batcher.max-parallel-requests | defaul=3)
* `GH__TREE__DIR_CONTENT__BATCHER__MAX_BATCH_SIZE` (original: graphouse.tree.dir-content.batcher.max-batch-size | defaul=2000)
* `GH__TREE__DIR_CONTENT__BATCHER__AGGREGATION_TIME_MILLIS` (original: graphouse.tree.dir-content.batcher.aggregation-time-millis | defaul=50)


##### Host metrics redirect

* `GH__HOST_METRICS_REDIRECT__ENABLE` (original: graphouse.host-metric-redirect.enabled | defaul=false)
* `GH__HOST_METRICS_REDIRECT__DIR` (original: graphouse.host-metric-redirect.dir | defaul=)
* `GH__HOST_METRICS_REDIRECT__POSTFIXES` (original: graphouse.host-metric-redirect.postfixes | defaul=)

##### Autohide

* `GH__AUTOHIDE__ENABLED` (original: graphouse.autohide.enabled | defaul=false)
* `GH__AUTOHIDE__RUN_DELAY_MINUTES` (original: graphouse.autohide.run-delay-minutes | defaul=30)
* `GH__AUTOHIDE__MAX_VALUES_COUNT` (original: graphouse.autohide.max-values-count | defaul=200)
* `GH__AUTOHIDE__MISSING_DAYS` (original: graphouse.autohide.missing-days | defaul=7)
* `GH__AUTOHIDE__STEP` (original: graphouse.autohide.step | defaul=10000)
* `GH__AUTOHIDE__RETRY__COUNT` (original: graphouse.autohide.retry.count | defaul=10)
* `GH__AUTOHIDE__RETRY__WAIT_SECONDS` (original: graphouse.autohide.retry.wait_seconds | defaul=10)
* `GH__AUTOHIDE__CLICKHOUSE__QUERY_TIMEOUT_SECONDS` (original: graphouse.autohide.clickhouse.query-timeout-seconds | defaul=600)

#### Metric validation

* `GH__METRIC_VALIDATION__MIN_LENGTH` (original: graphouse.metric-validation.min-length | defaul=10)
* `GH__METRIC_VALIDATION__MAX_LENGTH` (original: graphouse.metric-validation.max-length | defaul=200)
* `GH__METRIC_VALIDATION__MIN_LEVELS` (original: graphouse.metric-validation.min-levels | defaul=2)
* `GH__METRIC_VALIDATION__MAX_LEVELS` (original: graphouse.metric-validation.max-levels | defaul=15)
* `GH__METRIC_VALIDATION__REGEXP` (original: graphouse.metric-validation.regexp | defaul=[-_0-9a-zA-Z\\\\.]*$)
