Return-Path: <cygwin-patches-return-2097-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18857 invoked by alias); 24 Apr 2002 05:55:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18835 invoked from network); 24 Apr 2002 05:55:18 -0000
Message-ID: <3CC64964.1070103@ece.gatech.edu>
Date: Tue, 23 Apr 2002 22:55:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Packaging information
References: <3CC63684.3010207@ece.gatech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00081.txt.bz2

> On Wed, Apr 24, 2002 at 12:37:24AM -0400, Charles Wilson wrote:
>>Permission to apply?
> 
> AFAIAC, the setup.html is ok but I don't think that the generic-whatever
> stuff belongs on the web site.  Maybe the ftp directory or the
> cygwin-apps repository is more appropriate.


I think generic-* are just as much "documentation" as they are 
"resource"; so  the reader should be able to click on a link(*) and 
peruse them, without having to (a) fire up a different client and 
"download" them, or (b) fire up cvs and check them out.  That's just 
needless extra work -- documentation is supposed to make things easier, 
not more difficult; let's not create artificial barriers.

(*) even if it's 
"ftp://some-random-mirror/path/cygwin/resources/generic-foo".


--Chuck
