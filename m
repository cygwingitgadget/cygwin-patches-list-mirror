Return-Path: <cygwin-patches-return-2411-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20062 invoked by alias); 13 Jun 2002 13:29:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20008 invoked from network); 13 Jun 2002 13:29:23 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Conrad Scott'" <Conrad.Scott@dsl.pipex.com>,
	<cygwin-patches@cygwin.com>
Subject: RE: cygserver debug output patch
Date: Thu, 13 Jun 2002 06:29:00 -0000
Message-ID: <009901c212de$5bdb8cf0$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
In-Reply-To: <033701c212dd$a20d7ae0$6132bc3e@BABEL>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00394.txt.bz2



> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Conrad Scott
> Sent: Thursday, 13 June 2002 11:24 PM
..
> Since Chris is thinking that it would be a good idea to put 
> my cygserver /
> shm stuff on a branch, I can't think there's much point putting those
> patches I sent you into the main line, they could better go 
> on the branch.
> Does that sound reasonable to you?

I'll put them in mainline or the branch when I create it. I'm not sure
yet which they belong in - let me look at them first.
 
> Anyhow, the ipctests now run successfully on win 95 (thanks 
> to Nicholas for
> helping out on the patch, compile, test, report yet another 
> abject failure
> test cycle).

Cool. Thanks.
 
...
> IPC_RMID a segment that processes are still attached to: 

"IPC_RMID Remove the shared memory identifier specified by shmid from
the system and
destroy the shared memory segment and shmid_ds data structure associated
with it. IPC_RMID can only be executed by a process that has an
effective user
ID equal to either that of a process with appropriate privileges or to
the value
of shm_perm.cuid or shm_perm.uid in the shmid_ds data structure
associated
with shmid."

It seems fairly clear: the shm id is immediately removed from the
system, along with the shm segment and shmid_ds data structure.

> AFAICT it succeeds
> but the memory itself is only deleted on the last detach 
> (which I think is
> what the cygserver code does - or does now). 

Yes. I wasn't sure if that was right either :}. 

> The only issue I 
> can't find any
> reference to is what happens if you call shmat() or 
> shmctl(IPC_INFO) for
> that shmid after using IPC_RMID but before the segment itself 
> is deleted.

EINVAL.

> I'll have a look at the netbsd and the linux code and see 
> what they do, but
> if anyone has a good idea or any useful specs, I'd welcome the hint.

Good idea. For specs, check the open group, or IEEE 1003.1.

Rob
