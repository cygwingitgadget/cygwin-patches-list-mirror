Return-Path: <cygwin-patches-return-2410-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17628 invoked by alias); 13 Jun 2002 13:22:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17579 invoked from network); 13 Jun 2002 13:22:42 -0000
Message-ID: <033701c212dd$a20d7ae0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <00a901c21152$f82c52c0$0200a8c0@lifelesswks>
Subject: Re: cygserver debug output patch
Date: Thu, 13 Jun 2002 06:22:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00393.txt.bz2

Robert,

Since Chris is thinking that it would be a good idea to put my cygserver /
shm stuff on a branch, I can't think there's much point putting those
patches I sent you into the main line, they could better go on the branch.
Does that sound reasonable to you?

Anyhow, the ipctests now run successfully on win 95 (thanks to Nicholas for
helping out on the patch, compile, test, report yet another abject failure
test cycle).

I'm now playing around with deleting shmids (and their associated memory
segments). None of the standards are at all clear about what happens if you
IPC_RMID a segment that processes are still attached to: AFAICT it succeeds
but the memory itself is only deleted on the last detach (which I think is
what the cygserver code does - or does now). The only issue I can't find any
reference to is what happens if you call shmat() or shmctl(IPC_INFO) for
that shmid after using IPC_RMID but before the segment itself is deleted.
I'll have a look at the netbsd and the linux code and see what they do, but
if anyone has a good idea or any useful specs, I'd welcome the hint.

Cheers for now.

// Conrad


