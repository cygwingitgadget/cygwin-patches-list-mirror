Return-Path: <cygwin-patches-return-7638-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14898 invoked by alias); 11 Apr 2012 18:53:10 -0000
Received: (qmail 14666 invoked by uid 22791); 11 Apr 2012 18:53:07 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_NO,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout06.t-online.de (HELO mailout06.t-online.de) (194.25.134.19)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 11 Apr 2012 18:52:46 +0000
Received: from fwd21.aul.t-online.de (fwd21.aul.t-online.de )	by mailout06.t-online.de with smtp 	id 1SI2ep-0004b6-SE; Wed, 11 Apr 2012 20:52:43 +0200
Received: from [192.168.2.108] (SUO4YEZArhQBonx7U3+J1bavTnrUzLwdKegv3QR0zpTN8wQIANWMShIL-h4BQBOwpm@[79.224.118.109]) by fwd21.t-online.de	with esmtp id 1SI2ek-0ye6l60; Wed, 11 Apr 2012 20:52:38 +0200
Message-ID: <4F85D2F4.8090204@t-online.de>
Date: Wed, 11 Apr 2012 18:53:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Firefox/10.0.2 SeaMonkey/2.7.2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Setting TZ may break time() in non-Cygwin programs
References: <4F4FD8C6.5000807@t-online.de> <20120302091317.GD14404@calimero.vinschen.de> <4F513D11.2080203@t-online.de> <20120304115232.GC18852@calimero.vinschen.de> <4F53B791.2090709@t-online.de> <20120304204938.GL18852@calimero.vinschen.de>
In-Reply-To: <20120304204938.GL18852@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------080604070604050805090900"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q2/txt/msg00007.txt.bz2

This is a multi-part message in MIME format.
--------------080604070604050805090900
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1145

On Mar 4, Corinna Vinschen wrote:
> On Mar  4 19:42, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> On Mar  2 22:35, Christian Franke wrote:
>>>> Corinna Vinschen wrote:
>>>>> But, as usual, PTC.
>>>> OK, ...
>>>>
>>>>> Simple: Unset TZ for Win32 programs run from Cygwin.
>>>>>
>>>>> More flexible: Set (unset) TZ=CYGWIN_WINENV_TZ if this variable is
>>>>> set (to empty). Otherwise keep TZ as is.
>>>>>
>>>> would a patch for any of the above have a chance to get accepted?
>>> If it's not getting too complicated, yes.  However, the second idea
>>> I don't understand.  Can you explain this differently?
>>>
>> Let another variable change the value passed to Windows environment:
>>
>> $ printenv TZ
>> Europe/Berlin
>>
>> $ cmd /c echo %TZ%
>> Europe/Berlin
>>
>> $ export CYGWIN_WINENV_TZ=CET-1CEST
>>
>> $ printenv TZ
>> Europe/Berlin
>>
>> $ cmd /c echo %TZ%
>> CET-1CEST
>>
>> $ export CYGWIN_WINENV_TZ=
>>
>> $ cmd /c echo %TZ%
>> %TZ% (which means TZ is not set)
> Hmm.  I think just unsetting TZ should be sufficient.  MSVCRT uses the
> current timezone as default anyway, doesn't it?
>
>

Yes. Patch is attached.

Christian


--------------080604070604050805090900
Content-Type: text/x-diff;
 name="no-win32-tz.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="no-win32-tz.patch"
Content-length: 823

2012-04-11  Christian Franke  <franke@computer.org>

	* environ.cc (build_env): Don't pass POSIX TZ variable to Win32.
	TZ may result in incorrect time zone conversions from MSVCRT time
	functions.

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 33289d2..01ef234 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -1074,6 +1074,11 @@ build_env (const char * const *envp, PWCHAR &envblock, int &envc,
 	  if (len == 1 || !*rest)
 	    continue;
 
+	  /* Don't pass POSIX TZ variable to Win32.  TZ may result in
+	     incorrect time zone conversions from MSVCRT time functions.  */
+	  if (len == 3 && (*srcp)[0] == 'T' && (*srcp)[1] == 'Z')
+	    continue;
+
 	  /* See if this entry requires posix->win32 conversion. */
 	  conv = getwinenv (*srcp, rest, &temp);
 	  if (conv)

--------------080604070604050805090900--
