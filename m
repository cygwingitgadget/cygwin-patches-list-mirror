Return-Path: <cygwin-patches-return-2113-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18666 invoked by alias); 25 Apr 2002 16:31:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18623 invoked from network); 25 Apr 2002 16:30:59 -0000
Message-ID: <3CC82FE0.6020108@ece.gatech.edu>
Date: Thu, 25 Apr 2002 09:31:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Charles Wilson <cwilson@ece.gatech.edu>
CC: Robert Collins <robert.collins@itdomain.com.au>,
	cygwin-patches@cygwin.com
Subject: Re: Packaging information
References: <FC169E059D1A0442A04C40F86D9BA7600C5EF2@itdomain003.itdomain.net.au> <3CC780C0.5080302@ece.gatech.edu>
Content-Type: multipart/mixed;
 boundary="------------050807070803080001090809"
X-SW-Source: 2002-q2/txt/msg00097.txt.bz2

This is a multi-part message in MIME format.
--------------050807070803080001090809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 880



Charles Wilson wrote:

>>> Hey, yeah -- that'll work.  Where should generic-* go -- in one of 
>>> the existing repositories under cygwin-apps (probably not), or should 
>>> I create another?  If I should create another, what should it be 
>>> called? resources?
>>>
>>
>> Hmm. Lets be a bit more specific - why not call the module "packaging".
>> Then the generics can go in /templates or /samples or something like
>> that.
> 
> 
> 
> sounds find to me.
> 
> packaging/
> packaging/ChangeLog
> packaging/templates/
> packaging/templates/generic-build-script
> packaging/templates/generic-readme


Okay -- I've done this.  But, I've run into a snag: the cygwin-apps 
repository is not accessible via cvsweb.  Can somebody apply this patch 
to the file 'cvsweb.conf' in the 'cgi-bin' module of the 'sourceware' 
repository? (I don't have write access to that module).

--Chuck


--------------050807070803080001090809
Content-Type: text/plain;
 name="cvsweb.conf.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cvsweb.conf.diff"
Content-length: 616

Index: cvsweb.conf
===================================================================
RCS file: /cvs/sourceware/cgi-bin/cvsweb.conf,v
retrieving revision 1.51
diff -u -r1.51 cvsweb.conf
--- cvsweb.conf	17 Sep 2001 22:55:40 -0000	1.51
+++ cvsweb.conf	25 Apr 2002 16:28:54 -0000
@@ -29,6 +29,7 @@
             'c++-embedded' => '/cvs/c++-embedded',
             'cgen' => '/cvs/src',
             'cygwin' => '/cvs/cygwin',
+            'cygwin-apps' => '/cvs/cygwin-apps',
 	    'cygwin-xfree' => '/cvs/cygwin-xfree',
             'docbook-tools' => '/cvs/docbook-tools',
             'dominion' => '/cvs/dominion',

--------------050807070803080001090809--
