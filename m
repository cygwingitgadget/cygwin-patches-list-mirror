Return-Path: <cygwin-patches-return-2110-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4093 invoked by alias); 25 Apr 2002 04:03:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4078 invoked from network); 25 Apr 2002 04:03:46 -0000
Message-ID: <3CC780C0.5080302@ece.gatech.edu>
Date: Wed, 24 Apr 2002 21:03:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Collins <robert.collins@itdomain.com.au>
CC: cygwin-patches@cygwin.com
Subject: Re: Packaging information
References: <FC169E059D1A0442A04C40F86D9BA7600C5EF2@itdomain003.itdomain.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00094.txt.bz2

Robert Collins wrote:

> 
>>-----Original Message-----
>>From: Charles Wilson [mailto:cwilson@ece.gatech.edu] 
>>Sent: Thursday, April 25, 2002 1:24 AM
>>
> 
>>Hey, yeah -- that'll work.  Where should generic-* go -- in 
>>one of the 
>>existing repositories under cygwin-apps (probably not), or should I 
>>create another?  If I should create another, what should it 
>>be called? 
>>resources?
>>
> 
> Hmm. Lets be a bit more specific - why not call the module "packaging".
> Then the generics can go in /templates or /samples or something like
> that.


sounds find to me.

packaging/
packaging/ChangeLog
packaging/templates/
packaging/templates/generic-build-script
packaging/templates/generic-readme

--Chuck


