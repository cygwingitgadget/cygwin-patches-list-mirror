Return-Path: <cygwin-patches-return-5218-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5733 invoked by alias); 16 Dec 2004 16:24:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5579 invoked from network); 16 Dec 2004 16:24:31 -0000
Received: from unknown (HELO pmesmtp04.mci.com) (199.249.20.36)
  by sourceware.org with SMTP; 16 Dec 2004 16:24:31 -0000
Received: from pmismtp01.mcilink.com ([166.38.62.36])
 by firewall.mci.com (Iplanet MTA 5.2)
 with ESMTP id <0I8T00BGOPJWG7@firewall.mci.com> for cygwin-patches@cygwin.com;
 Thu, 16 Dec 2004 16:23:56 +0000 (GMT)
Received: from pmismtp01.mcilink.com by pmismtp01.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0I8T00101PJVZ6@pmismtp01.mcilink.com> for
 cygwin-patches@cygwin.com; Thu, 16 Dec 2004 16:23:56 +0000 (GMT)
Received: from WS117V6220509.mcilink.com ([166.34.132.122])
 by pmismtp01.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0I8T001JKPJWAZ@pmismtp01.mcilink.com> for
 cygwin-patches@cygwin.com; Thu, 16 Dec 2004 16:23:56 +0000 (GMT)
Date: Thu, 16 Dec 2004 16:24:00 -0000
From: Mark Paulus <mark.paulus@mci.com>
Subject: Re: Patch to allow trailing dots on managed mounts
In-reply-to: <20041216160950.GI23488@trixie.casa.cgf.cx>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-id: <0I8T001JLPJWAZ@pmismtp01.mcilink.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Priority: Normal
X-SW-Source: 2004-q4/txt/msg00219.txt.bz2

Which is why I did what I did.
If you look, my patch allows for checking to see 
if "............................." was entered as an argument, and 
throws the exception if it was.  THEN, if that is not the case,
it passes the FULL name to conv_to_win32_path to allow
for proper demangling rules.


On Thu, 16 Dec 2004 11:09:50 -0500, Christopher Faylor wrote:

>On Thu, Dec 16, 2004 at 11:06:07AM -0500, Christopher Faylor wrote:
>>On Thu, Dec 16, 2004 at 05:03:22PM +0100, Corinna Vinschen wrote:
>>>On Dec 16 10:57, Christopher Faylor wrote:
>>>> On Thu, Dec 16, 2004 at 04:53:39PM +0100, Corinna Vinschen wrote:
>>>> >Since the mount code is called from path_conv anyway, wouldn't it be
>>>> >better to pass the information "managed mount or not" up to path_conv?
>>>> 
>>>> How about just doing the pathname munging in `conv_to_win32_path' if/when
>>>> it's needed?
>>>
>>>Erm... I'm not quite sure, but didn't the "remove trailing dots and spaces"
>>>code start there and has been moved to path_conv by Pierre to circumvent
>>>some problem?  I recall only very vaguely right now.
>>
>>One problem that it would circumvent is that currently, if you do this:
>>
>>ls /bin......................................
>>
>>You'll get a listing of the bin directory.  If you move the code to
>>conv_to_win32_path that may not be as easy to get right.

>That's the problem with somehow getting the information back to
>path_conv::check, too, I think.  It's a chicken/egg situation.  You need
>to regularize the path name before looking through the mount table to
>find out if the file is controlled by a managed mount.

>cgf


