Return-Path: <cygwin-patches-return-2485-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24653 invoked by alias); 21 Jun 2002 23:18:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24638 invoked from network); 21 Jun 2002 23:18:19 -0000
Message-ID: <00bc01c2197a$2e4edce0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Earnie Boyd" <Cygwin-Patches@Cygwin.Com>
Cc: <cygwin-patches@cygwin.com>
References: <03bf01c2191a$af67ba50$6132bc3e@BABEL> <3D1317FE.EBB92CF3@yahoo.com>
Subject: Re: Add FILE_FLAG_FIRST_PIPE_INSTANCE to <w32api/winbase.h>
Date: Fri, 21 Jun 2002 16:18:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00468.txt.bz2

"Earnie Boyd" <earnie_boyd@yahoo.com> wrote:
> MSDN says that this is Win2000 SP2 and XP only.  So you need to
guard it
> with the appropriate WINVER constant.

Sorry about my earlier querulous email: I was blissfully ignorant of
the whole WINVER system.

My problem now is to choose a relevant version number to check
against. As far as I can dig out of MSDN, win2k has _WIN32_WINNT set
to 0x0500 and XP has it set to 0x0501. So, unlike some earlier
systems, there's no space for extra version numbers for service pack
releases.

So, to guard a define that's only available in win2k SP2 and in XP,
which value should I use? (win2k or XP?) or is there some other value
that is available now for service pack version information?

// Conrad


