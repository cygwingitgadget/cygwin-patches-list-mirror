Return-Path: <cygwin-patches-return-2127-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18774 invoked by alias); 30 Apr 2002 14:08:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18748 invoked from network); 30 Apr 2002 14:08:23 -0000
Message-ID: <3CCEA638.E357EFE2@ieee.org>
Date: Tue, 30 Apr 2002 07:08:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: SSH -R problem
References: <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020430073223.007e3e00@mail.attbi.com> <20020430142039.D1214@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00111.txt.bz2

Corinna Vinschen wrote:
> 
> That makes sense... but doesn't that again break something else?

What it might break is the case for which linger was added in the first 
place, i.e. processes terminating and Windows flushing their outgoing 
packet queue (in the case of slow connections), as opposed to Unix, 
which maintains the queue for a while after process termination.

Now I have never observed this myself, and don't have a strong opinion.
Do we have a reproducible case to understand exactly what's going on?
I am not convinced by the "user space" argument in
http://cygwin.com/ml/cygwin/2001-07/msg00855.html
We know too well that sockets consume system buffers.

At any rate the initial problem occurs only at process termination time.
The current issue is that we don't want to block processes in the prime of
their life. 
So an ideal fix would detect "end of life" situations. Here is a brain 
storming idea: on a Cygwin close(), do a shutdown(.,2), free the Cygwin
structure and start a task to do a blocking linger + closesocket() on the
Windows socket. At process termination, wait until all such tasks are done.
Exception: in the case of a blocking socket where the application had
set linger to On, do a Windows closesocket() immediately.

By the way, how does Unix behave when doing a close() on a non blocking
socket when linger is on? That seems contradictory, linger on is supposed
to block...
"SO_LINGER controls the action taken when unsent messages are queued on
socket and a close(2) is performed.  If the socket promises reliable
delivery of data and SO_LINGER is set, the system will block the process
.."

Short of something like this we are between a rock and a hard place.
I would think that applications that go to the trouble of setting the
socket to non-blocking care more about not blocking than about potentially
dropping packets at the end of their life.

Pierre
