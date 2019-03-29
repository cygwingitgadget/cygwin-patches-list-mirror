Return-Path: <cygwin-patches-return-9273-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18060 invoked by alias); 29 Mar 2019 20:11:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18048 invoked by uid 89); 29 Mar 2019 20:11:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,SPF_PASS autolearn=ham version=3.3.1 spammy=explains, hundred, somewhere
X-HELO: mx009.vodafonemail.xion.oxcs.net
Received: from mx009.vodafonemail.xion.oxcs.net (HELO mx009.vodafonemail.xion.oxcs.net) (153.92.174.39) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 29 Mar 2019 20:11:18 +0000
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 425FFD9B2B2	for <cygwin-patches@cygwin.com>; Fri, 29 Mar 2019 20:11:15 +0000 (UTC)
Received: from Gertrud (unknown [87.185.211.111])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 129F5199C19	for <cygwin-patches@cygwin.com>; Fri, 29 Mar 2019 20:11:12 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
References: <20190325230556.2219-1-kbrown@cornell.edu>	<20190326083620.GI3471@calimero.vinschen.de>	<1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu>	<20190326190136.GC4096@calimero.vinschen.de>	<20190327133059.GG4096@calimero.vinschen.de>	<87k1gi3mle.fsf@Rainer.invalid>	<20190328201317.GZ4096@calimero.vinschen.de>	<d4cb62f1-5754-aff2-c23d-7ce65f5a5726@cornell.edu>	<87o95u5eu0.fsf@Rainer.invalid>	<f8b66caf-7673-f92b-ed2e-127b387f1f09@cornell.edu>
Date: Fri, 29 Mar 2019 20:11:00 -0000
In-Reply-To: <f8b66caf-7673-f92b-ed2e-127b387f1f09@cornell.edu> (Ken Brown's	message of "Fri, 29 Mar 2019 18:05:18 +0000")
Message-ID: <87tvfljvaa.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q1/txt/msg00083.txt.bz2

Ken Brown writes:
> I found a bug in my fhandler_fifo::raw_write code that could explain the 
> problem.  The call to NtWriteFile in that function always returns immediately 
> because the Windows named pipe underlying the FIFO is non-blocking.  If it can't 
> write because the pipe buffer is full, raw_write returns -1 with error EAGAIN. 
> That's wrong if the FIFO was opened in blocking mode.

Sounds like a clue or at least it doesn#t contradict what I'm seeing.  I
have no idea if that explains all the problems I'm seeing, I'll describe
them in more detail below.

> I'll have to think about how to best handle this.  I think I might be able to 
> imitate what's done in fhandler_socket_unix::sendmsg in the topic/af_unix branch.

OK, a bit more info: The whole thing runs from a perl script (actually a
module) that opens pipes to gnuplot and ghostscript.  This code is
_really_ old and has seen a lot of Cygwin releases, so it has options to
either use temporary files, named pipes aka FIFO or direct pipes.  Using
temporary files serializes the execution and using a pipe chain is
_really_ slow (like a hundred times, which is mostly tied up in system
for a reason that I don't understand), so using FIFO is the default.
Your new FIFO code increases the system time by about a factor of 10 in
my tests, btw.

The error with the FIFO to gnuplot is that some data that was written
into the FIFO already doesn't show up at the reader end, but later data
written into it does.  Here somewhere around a few kiB go missing and
gnuplot runs into a syntax error when it happens.

If I run gnuplot through a plain pipe to skip that error, but keep
ghostscript on FIFO, then it _almost_ works correctly.  Except that once
gnuplot has finished writing to the FIFO I need to write the bookmarks
dictionary before closing the output file and that write again
overwrites data that should already have been present at the other side.
I've played a bit with putting in flushes and sleeps and there's between
one to three pages at the end of the document that go missing, so again
a handful of KiB.

So either of these two errors indiqcates problems with synchronizing the
reader/writer side, which makes some of the written data disappear on
the receiving end of the FIFO.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Q+, Q and microQ:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
