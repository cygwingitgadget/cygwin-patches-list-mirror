Return-Path: <cygwin-patches-return-2523-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4031 invoked by alias); 26 Jun 2002 17:22:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3969 invoked from network); 26 Jun 2002 17:22:08 -0000
Message-ID: <3D19F812.70509@netscape.net>
Date: Wed, 26 Jun 2002 12:45:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: A minor patch to Makefile.in
References: <3D19F55E.3070800@netscape.net>
Content-Type: multipart/mixed;
 boundary="------------030600060509050400010206"
X-SW-Source: 2002-q2/txt/msg00506.txt.bz2


--------------030600060509050400010206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 313

Ok,

A correction:
"Due to the dependancy of gettext(libintl) and gettext, this pach..."

This should read:
"Due to the dependancy of gettext(libintl) on libiconv, this patch..."

Also, Netscape is stripping tabs, so I have attached the Changelog this 
time with the hope it won't be stripped.

Cheers,
Nicholas


--------------030600060509050400010206
Content-Type: text/plain;
 name="Changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Changelog.txt"
Content-length: 151

2002-06-26  Nicholas S. Wourms <nwourms@netscape.net>

    * utils/Makefile.in: Fix so that dumper.exe will link against
    the new gettext properly.

--------------030600060509050400010206--
