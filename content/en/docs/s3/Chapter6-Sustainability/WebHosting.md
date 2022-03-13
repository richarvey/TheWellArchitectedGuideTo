---
title: "Static Web Hosting"
linkTitle: "Static Web Hosting"
weight: 2 
date: 2022-01-01
description: 
    How to host simple websites
---
<span class=opex-off>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-sec>Cost</span>
<span class=sus-on>Sus</span>

Static web hosting is one of my favourite parts of S3. You can simply upload a static site to a bucket and serve the pages straight away. It's worth noting S3 doesn't support any serverside processing, so you need a static website. There are lots of options here, my favourite is goHugo but I've included a list for you to get started:

- https://gohugo.io/
- https://www.gatsbyjs.com/
- https://jekyllrb.com
- https://nextjs.org
- https://react-static.js.org/
- https://vuepress.vuejs.org

Serving a static website from a traditional server is wasteful. It sits idel most of the time, you may even runn XX more servers ready for peak load wasting even more enegery. S3 web hosting is different. The webserveres only lift your content into memory to serve when a request comes in. AT times when there is no traffic you data storage is all that is taking energy thus greatly reducing your usage and my reasoning for making this section a sustainability section. It's also increadly cheep to host your site in this way.

By default, you'll be serving your website from its bucket name and region name. For example:

- s3-website dash (-) Region ‐ http://bucket-name.s3-website-Region.amazonaws.com

It's also worth noting that the endpoint is http and not https! 

### Adding a DNS CNAME
If you have a registered domain, you can add a DNS __CNAME__ entry to point to the Amazon S3 website endpoint. For example, if you registered the domain www.squarecows.com, you could create a bucket called www.squarecows.com, and add a DNS CNAME record that points to www.squarecows.com.s3-website.Region.amazonaws.com. All requests to http://www.squarecows.com are routed to www.squarecows.com.s3-website.Region.amazonaws.com.

Whilst this is a nicer way to host your site with a friendly URL it still lacks HTTPS and these days that will affect your search engine rankings.

#### The Apex zone issue!
Whilst Amazon Route53 allows you to point the apex record (in this case squarecows.com) at a bucket by a CNAME or alias, manny other providers will not allow you to do this because it's against the RFC. Instead you are required to point at an IP address. Theres no real fix for this and I would recomend moving you DNS hosting into Route53 to avoid potential issues.

### Enabling Hosting
I've included the terraform to help you create an S3 website, however, you can also do this from the AWS CLI. When you create the website endpoint you need to specify your index page (normally an object named _index.html_) and your error document (normally and object nammed _error.html_).

```bash
aws s3 website s3://my-bucket/ --index-document index.html --error-document error.html
```

For the Terraform check out FHGJDHFSFSGDSHJGHFJ

You are also required to make sure the bucket is publically readable so you need to grant access as _public_ and remove the disable public block section from your bucket configuration. If you have objects that are uploaded by people other than the bucket owner you will also have to grant read access to everybody. Here are the steps to disable the public block which is on by default:

- Open the Amazon S3 console at https://console.aws.amazon.com/s3/.
- Choose the name of the bucket that you have configured as a static website.
- Choose Permissions.
- Under Block public access (bucket settings), choose Edit.
- Clear Block all public access, and choose Save changes.

![The public block policies disabled](../edit-public-access-clear.png "The public block policies disabled")

Now you've cleard these block policies you must do the bit I always for get to do! Add a bucket policiy to allow all the objects to be readable by everyone! This basically ensures all objects have the s3:GetObject permission.

- Under Buckets, choose the name of your bucket.
- Choose Permissions.
- Under Bucket Policy, choose Edit.
- To grant public read access for your website, copy the following bucket policy, and paste it in the Bucket policy editor.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::Bucket-Name/*"
            ]
        }
    ]
}
```

- Update the Resource to your bucket name.
In the preceding example bucket policy, Bucket-Name is a placeholder for the bucket name. To use this bucket policy with your own bucket, you must update this name to match your bucket name.
- Choose Save changes.
A message appears indicating that the bucket policy has been successfully added.

