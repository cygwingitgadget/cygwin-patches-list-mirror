Return-Path: <cygwin-patches-return-2482-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 774 invoked by alias); 21 Jun 2002 12:13:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 730 invoked from network); 21 Jun 2002 12:13:43 -0000
Message-ID: <3D1317FE.EBB92CF3@yahoo.com>
Date: Fri, 21 Jun 2002 05:13:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
X-Accept-Language: en
MIME-Version: 1.0
To: Conrad Scott <Conrad.Scott@dsl.pipex.com>
CC: cygwin-patches@cygwin.com
Subject: Re: Add FILE_FLAG_FIRST_PIPE_INSTANCE to <w32api/winbase.h>
References: <03bf01c2191a$af67ba50$6132bc3e@BABEL>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00465.txt.bz2

MSDN says that this is Win2000 SP2 and XP only.  So you need to guard it
with the appropriate WINVER constant.

Earnie.

P.S.: This list is fine for w32api patches.

Conrad Scott wrote:
> 
> I've attached a patch to add the (new-ish) CreateNamedPipe flag
> FILE_FLAG_FIRST_PIPE_INSTANCE to <w32api/winbase.h>.
> 
> // Conrad
> 
> [This seems to be the correct mailing list for w32api patches. Please
> forward this on and/or give me a hint otherwise. Thanks.]
> 
> 2002-06-21  Conrad Scott  <conrad.scott@dsl.pipex.com>
> 
>  * include/winbase.h: Add file open flag
> FILE_FLAG_FIRST_PIPE_INSTANCE.
> 
>   ------------------------------------------------------------------------
>                    Name: w32api.patch
>    w32api.patch    Type: unspecified type (application/octet-stream)
>                Encoding: quoted-printable
> 
>                     Name: ChangeLog.txt
>    ChangeLog.txt    Type: Plain Text (text/plain)
>                 Encoding: 7bit
