# Proof of Concept

> A proof of concept of running WordPress in Docker on Zeit's Now

This is an experimental examination of running WordPress inside a Docker image
and host it on [Zeit's Now service](https://zeit.co/now).

## Why

I like WordPress. It's suprisingly fun to develop in and alot of people are
familiar with it which makes it ideal for client websites which needs a both
cheap and reliable content management system.

But what I don't like about it is some of the concepts that it enforces with
very tight coupling between front end, back end, database and file storage.
Often these things live right by each other on one and the same server.

This makes versioning very hard, and enabling staging and development
environments demands some special workarounds, if you're not on a managed host.

I want to try and solve this. I want to decoulpe the database and file storage
from the actual WordPress code and make deployments immutable and disposable.

## The goal

My goal is to run WordPress inside some sort of nginx/php-fpm docker image which
can be deployed to Zeit's Now service.

I hope that all this will result in a more lean and fast site when utilizing
Now's horizontal scaling, which, if I pay for it, can be managed automatically.

My goal is also to increase the developer experience. Developing in WordPress
can be a bit tiresome and it's hard to utilize things such as git and package
management. I hope that the Docker environment, together with something like
[roots/bedrock](https://github.com/roots/bedrock), will make development
smoother.

## Problems

Deployments on Now is supposed to be stateless, immutable and disposable. But
WordPress, as normally used, is everything but those things.

Before jumping in I see two main hurdles:

### Database

First I need to move the database outside of the container. This is probably
quite easy. There is a ton of managed database-as-a-service (DaaS) providers out
there. But I will give [AWS RDS](https://aws.amazon.com/rds/) a go. It's cheap
and it's easy to clone the database for staging and development environments.

### Uploads

The other issue is file uploads. Uploading a file through WordPress will put it
in the `uploads` folder inside `wp-content` on your server. But I want to use
Now which will scale up and down as it likes and the uploads folder will be
fresh and clean on every new deployment. So I have to find another solution
there.

Right now I'm looking into using [AWS S3](https://aws.amazon.com/s3/) together
with [humanmade/S3-Uploads](https://github.com/humanmade/S3-Uploads). This will
also enable me to utilize something like CloudFlare or AWS CloudFormation as a
content delivery network in front of my S3 bucket hopefully resulting in faster
delivery of content.

---

Feel free to follow along and see how this thing goes! And please reach out to
me if you've made something similar!
