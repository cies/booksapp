# BookApp

Example application of a modern day client-server app.

[Demo of the client](http://cies.github.io/booksapp) hooking
directly into the Google Books API, thus not using the supplied
proxy server.


## Installation

We use `bundler`, so first get that to work.

Then from the root of this repo run:

    bundle install


## Design contraints

For the server:

* a proxy for Google Books API
* in Ruby
* fast-as-possible
* only proxies what the clients needs
* can run on [Heroku](http://heroku.com)

For the client:

* Angular.js based
* Bootstrap CSS based
* consumes what the server offers


## Benchmark

To benchmark we ran:

    thin -s 1 -e production -R ./config.ru start
    siege -c 64 -t 1m "http://0.0.0.0:3000/books/v1/volumes?q=ruby+rails&maxResults=40"

Which resulted on a small VM with Linux on a MacBook in:

    Lifting the server siege...      done.
    Transactions:                   6705 hits
    Availability:                 100.00 %
    Elapsed time:                  59.71 secs
    Data transferred:             684.81 MB
    Response time:                  0.05 secs
    Transaction rate:             112.29 trans/sec
    Throughput:                    11.47 MB/sec
    Concurrency:                    5.97
    Successful transactions:        6705
    Failed transactions:               0
    Longest transaction:            0.47
    Shortest transaction:           0.00


