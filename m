Return-Path: <cygwin-patches-return-2114-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4127 invoked by alias); 25 Apr 2002 18:44:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4090 invoked from network); 25 Apr 2002 18:44:53 -0000
Message-ID: <3CC84E9F.7010101@ece.gatech.edu>
Date: Thu, 25 Apr 2002 11:44:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Charles Wilson <cwilson@ece.gatech.edu>
CC: Robert Collins <robert.collins@itdomain.com.au>, cygwin-patches@cygwin.com
Subject: Re: Packaging information
References: <FC169E059D1A0442A04C40F86D9BA7600C5EF2@itdomain003.itdomain.net.au> <3CC780C0.5080302@ece.gatech.edu> <3CC82FE0.6020108@ece.gatech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00098.txt.bz2

Charles Wilson wrote:

> 
> Okay -- I've done this.  But, I've run into a snag: the cygwin-apps 
> repository is not accessible via cvsweb.  Can somebody apply this patch 
> to the file 'cvsweb.conf' in the 'cgi-bin' module of the 'sourceware' 
> repository? (I don't have write access to that module).


Thanks, whoever did this.  I've now committed the new setup.html (with 
the generic-* links modified to point to cvsweb).  Check it out:

http://www.cygwin.com/setup.html

--Chuck

