Return-Path: <cygwin-patches-return-5017-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12833 invoked by alias); 5 Oct 2004 16:26:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12819 invoked from network); 5 Oct 2004 16:26:34 -0000
From: "Bob Byrnes" <byrnes@curl.com>
Date: Tue, 05 Oct 2004 16:26:00 -0000
In-Reply-To: <20041004152225.GA22907@cygbert.vinschen.de>
       from Corinna Vinschen (Oct  4,  5:22pm)
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: Re: More pipe problems (was Re: [Fwd: 1.5.11-1: sftp performance problem])
Message-Id: <20041005162633.4295AE556@wildcard.curl.com>
X-SW-Source: 2004-q4/txt/msg00018.txt.bz2

I've been working on this, and I think I now understand the underlying
problem, but I don't yet have a fix.

The problem is that NtQueryInformationFile is stranger than I ever imagined.

First, some background, to be sure we're all speaking the same language:
Windows pipes actually seem more similar to UNIX domain sockets than
POSIX pipes.  In particular, Windows pipes have a server side and a
client side.

Most of the Windows pipe terminology is from the standpoint of the server.
An "inbound" pipe transfers data only in the client->server direction, an
"outbound" pipe transfers server->client, and a "duplex" pipe transfers
both ways.

We use CreateNamedPipe to make an inbound pipe for reading: this is the
server side.  Only the input buffer size is relevant for such a pipe ...
we should probably set the output buffer size to zero to emphasize that it
is not used.  We currently set both input and output buffer sizes to the
same value, which is harmless but misleading.

We then use CreateFile to obtain a handle to the other (client) side of
the pipe for writing, with attributes to allow NtQueryInformationFile
to work.

When we call NtQueryInformationFile with the FilePipeLocalInformation
parameter (FILE_INFORMATION_CLASS), it fills in a FILE_PIPE_LOCAL_INFORMATION
struct, which contains the following fields (among others that are not
directly related to pipe buffering):

  ULONG InboundQuota;
  ULONG ReadDataAvailable;
  ULONG OutboundQuota;
  ULONG WriteQuotaAvailable;

The InboundQuota and OutboundQuota are the input and output buffer sizes,
respectively, that were specified for CreateNamedPipe.  For our pipe
configuration, therefore, the OutboundQuota is irrelevant: we should be
checking the InboundQuota when we are interested in the pipe size.  This
does not currently affect us because we set InboundQuota == OutboundQuota,
but we should fix it.

The ReadDataAvailable field is always zero on the client side of an inbound
pipe.  We're ignoring it, as we should be.

Our code assumes that the WriteQuotaAvailable field tells how much space is
available for writing.  Well, not quite.

For an empty pipe, WriteQuotaAvailable == InboundQuota.  When data has
been written to the pipe (but not yet read by the other side), then
WriteQuotaAvailable is decremented by the appropriate amount, until
the pipe is full, when WriteQuotaAvailable is zero.  WriteFile blocks
only when it tries to write more than WriteQuotaAvailable.  All of this
is normal and expected.

But there is a strange twist:  When a read is pending on an empty pipe,
then WriteQuotaAvailable is also decremented!  I can't imagine why this
would be the case, but it is easy to demonstrate using a pair of small
test programs that I wrote to experiment with pipe buffering.

This behavior is unfortunate, because it means that we aren't currently
distinguishing pending reads and writes.  However, now that I understand
what's really going on, I can focus on working around it.

We have been baffled by the apparent contradiction that was nicely
summarized by Corinna:

> Do I understand that right?  sftp is in the blocking read on the pipe,
> there is data in the pipe and nevertheless read doesn't return?  That's odd.

ReadFile only blocks when the pipe is completely empty.  If there is
any data in the pipe, then it returns immediately, possibly supplying
less data than was requested.

When ReadFile blocks, there really isn't any data in the pipe.  Our select
code is just confused by the decremented WriteQuotaAvailable field, because
it looks like a *write* is pending!  So we start to throttle the writes,
which causes the data transfer to slow down, or even to block (if the
requested read was large enough).

I think my speculations about POSIX atomicity requirements related to
PIPE_BUF were a red herring.  Ditto for hypothetical bizarre pipe
buffering behavior.  The real problem here is NtQueryInformationFile.

I want to first try reversing the direction of the pipe.  We don't really
care which end is the server or client, so we could easily modify our pipe
creation code to make an outbound pipe, and if WriteQuotaAvailable from
NtQueryInformationFile behaves sanely, then we're done.

If that doesn't work, then I have some other ideas about how to distinguish
pending reads and writes.

I hope to have more info to report soon.

--
Bob
