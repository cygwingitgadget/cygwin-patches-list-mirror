Return-Path: <cygwin-patches-return-2494-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12866 invoked by alias); 23 Jun 2002 09:54:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12803 invoked from network); 23 Jun 2002 09:54:35 -0000
Message-ID: <066301c21a9c$3534fa80$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Robert Collins" <robert.collins@syncretize.net>
Cc: <cygwin-patches@cygwin.com>
References: <000601c21a8b$bd8324e0$0200a8c0@lifelesswks>
Subject: Re: Resubmission of cygwin_daemon patch.
Date: Sun, 23 Jun 2002 04:20:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00477.txt.bz2

"Robert Collins" <robert.collins@syncretize.net> wrote:
> There seems to be a lot of code duplication - definitions copied to
make
> private versions, that sort of thing. Can you elaborate on why? I
> strongly prefer to only have one instance of such things to prevent
skew
> occuring.

Rob, as I was having a bath I realised what you are might be referring
to. There are definitions of various internal shm structs and classes
in <sys/shm.h> that are no longer used anywhere (as they are broken:
shm.cc needed to see both class shmid_ds and struct shmid_ds). I've
removed these from that file on the cygwin_daemon branch (and so were
removed in the first version of the patch I submitted) but in
excluding the ipcs-related changes, I removed *all* changes to the
<sys/shm.h> and <sys/ipc.h> files (just me being lazy, sorry about
that). So, when these files are included, the __INSIDE_CYGWIN__ flags
are munged to make sure that those internal type definitions are never
visible. (I think the real ones are now in cygserver_shm.h but I'm out
of time to check right now.) So, you can just expunge those types from
<sys/shm.h> or leave them. They'll disappear as soon as I submit the
next patch, which will include ipcs(8) stuff (RSN etc.).

I hope that's the only such duplication in the patches. Please tell me
of any others.

Cheers,

// Conrad


