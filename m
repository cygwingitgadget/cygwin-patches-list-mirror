Return-Path: <cygwin-patches-return-2483-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25170 invoked by alias); 21 Jun 2002 13:25:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25156 invoked from network); 21 Jun 2002 13:25:14 -0000
Message-ID: <073c01c21927$5068a750$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Earnie Boyd" <Cygwin-Patches@Cygwin.Com>
Cc: <cygwin-patches@cygwin.com>
References: <03bf01c2191a$af67ba50$6132bc3e@BABEL> <3D1317FE.EBB92CF3@yahoo.com>
Subject: Re: Add FILE_FLAG_FIRST_PIPE_INSTANCE to <w32api/winbase.h>
Date: Fri, 21 Jun 2002 06:25:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00466.txt.bz2

"Earnie Boyd" <earnie_boyd@yahoo.com> wrote:
> MSDN says that this is Win2000 SP2 and XP only.  So you need to
guard it
> with the appropriate WINVER constant.

Earnie, I'm a bit confused about these WINVER guards.  The use of a
new Win2000 SP2 and XP only flag like this is not a compile-time but a
run-time issue, i.e. I should be able to compile a program using such
a flag on any platform and the application should act check at
run-time whether the flag is supported on whatever it is running on.
So, to use such a flag in a program, it seems I would need to add a
#define WINVER into the compilation to get access to the flag and then
add code (as I have) to check the windows version at run-time when
using the flag.

Given this, it doesn't seem much point having such WINVER guards. Am I
missing something here?

// Conrad


