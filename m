Return-Path: <cygwin-patches-return-4836-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 902 invoked by alias); 16 Jun 2004 11:32:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 850 invoked from network); 16 Jun 2004 11:31:58 -0000
Message-Id: <3.0.5.32.20040616072824.00812cf0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 16 Jun 2004 11:32:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Unicode length
In-Reply-To: <20040616072900.GZ1365@cygbert.vinschen.de>
References: <3.0.5.32.20040616003625.0081c940@incoming.verizon.net>
 <3.0.5.32.20040616003625.0081c940@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00188.txt.bz2

At 09:29 AM 6/16/2004 +0200, Corinna Vinschen wrote:
>Hi Pierre,
>
>On Jun 16 00:36, Pierre A. Humblet wrote:
>> This has not yet been fully tested.
>> 
>> There is a similar problem in str2buf2uni_cat and perhaps
>> elsewhere, but it's late.
>> Perhaps the debug_printf should be in sys_mbstowcs.
>>  
>> Pierre
>> 
>> 2004-06-16  Pierre Humblet <pierre.humblet@ieee.org>
>> 
>> 	* security.cc (str2buf2uni): Set the unicode length from the
>> 	return value of sys_mbstowcs().
>
>This change looks not quite ok.  The return value from MultiByteToWideChar
>is the "number of wide characters" while Length and MaximumLength in a
>UNICODE_STRING are defined to contain "the length in bytes".

Right, that's why the return value is multiplied by sizeof (WCHAR), as in
+  tgt.MaximumLength = sys_mbstowcs (buf, srcstr, strlen (srcstr) + 1) * sizeof (WCHAR);

After sleeping over it I see other issues. An accented string can have several
unicode representations, e.g. with composite characters or with precomposed 
characters. Do you know if NT prefers or insists on one or the other for filenames?
If it uses composite characters we should pass the right flag to MultiByteToWideChar.
Also in that case (and perhaps others ?) the unicode string can be longer (in wchar)
than the original string (in char). It would be necessary to pass the maximum unicode
length to str2buf2uni, instead of assuming it is strlen (srcstr) + 1.

Pierre
