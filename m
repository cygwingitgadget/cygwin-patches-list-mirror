Return-Path: <cygwin-patches-return-2942-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19867 invoked by alias); 6 Sep 2002 13:31:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19840 invoked from network); 6 Sep 2002 13:31:02 -0000
Message-ID: <3D78ADE3.10807@netscape.net>
Date: Fri, 06 Sep 2002 06:31:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Patching calls.texinfo
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00390.txt.bz2

Hi,

To be quite honest, I'm not familiar with the numbering 
schema in calls.texinfo for the C standards.  I wanted to 
submit a patch for isblank(), which falls under the same 
standard as isalpha() & friends.  Although isblank() and 
isalpha() are listed in The Open Group Base Specifications 
Issue 6: IEEE Std 1003.1-2001, I cannot find any reference 
to the numbering, which is used in that texinfo file, on The 
Open Groups site.  Can someone give me a hint so that I 
might submit a proper documentation patch?

Cheers,
Nicholas
