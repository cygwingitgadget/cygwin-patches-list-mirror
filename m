Return-Path: <cygwin-patches-return-2413-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23927 invoked by alias); 13 Jun 2002 14:33:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23911 invoked from network); 13 Jun 2002 14:33:41 -0000
Message-ID: <037601c212e7$8a9f8290$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Cc: "Robert Collins" <robert.collins@syncretize.net>
References: <009901c212de$5bdb8cf0$0200a8c0@lifelesswks>
Subject: Re: cygserver debug output patch
Date: Thu, 13 Jun 2002 07:33:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00396.txt.bz2

"Robert Collins" <robert.collins@syncretize.net> wrote:
> "IPC_RMID Remove the shared memory identifier specified by shmid from
> the system and destroy the shared memory segment and shmid_ds data
> structure associated with it. IPC_RMID can only be executed by a process
> that has an effective user ID equal to either that of a process with
> appropriate privileges or to the value of shm_perm.cuid or shm_perm.uid
> in the shmid_ds data structure associated with shmid."
>
> It seems fairly clear: the shm id is immediately removed from the
> system, along with the shm segment and shmid_ds data structure.
>
> For specs, check the open group, or IEEE 1003.1.

That's what I was looking at before I sent my email. Perhaps I could try
*reading* stuff rather than just *looking* at it next time. Sigh.

So, yes, what's required is perfectly clear. What's not clear is how to
implement that on win32 since file mappings only (AFAIK) disappear when the
last handle to them are closed and any views are unmapped, i.e. there is no
explicit delete operation for them. I don't currently see any good solution
to this. Then again, if that's what programs expect RMID to do, they won't
call it unless they've detached from the segment: i.e. they won't rely on it
staying around (if they're conformant)! So a laxity in that regard might not
be critical.

// Conrad


