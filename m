Return-Path: <cygwin-patches-return-5252-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27747 invoked by alias); 18 Dec 2004 23:35:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27719 invoked from network); 18 Dec 2004 23:35:36 -0000
Received: from unknown (HELO smartmx-03.inode.at) (213.229.60.35)
  by sourceware.org with SMTP; 18 Dec 2004 23:35:36 -0000
Received: from [62.99.252.218] (port=63513 helo=[192.168.0.2])
	by smartmx-03.inode.at with esmtp (Exim 4.34)
	id 1Cfo6p-0006jT-MF
	for cygwin-patches@cygwin.com; Sun, 19 Dec 2004 00:35:36 +0100
Message-ID: <41C4BEB9.7090205@x-ray.at>
Date: Sat, 18 Dec 2004 23:35:00 -0000
From: Reini Urban <rurban@x-ray.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8a4) Gecko/20040927
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
References: <3.0.5.32.20041216224347.0082d210@incoming.verizon.net> <20041217061741.GG26712@trixie.casa.cgf.cx> <41C31496.4D9140C7@phumblet.no-ip.org> <20041217175649.GA1237@trixie.casa.cgf.cx> <41C36530.89F5A621@phumblet.no-ip.org> <20041218003615.GB3068@trixie.casa.cgf.cx> <20041218172053.GA9932@trixie.casa.cgf.cx> <41C476F1.6060700@x-ray.at> <41C49377.57107AA9@dessent.net> <Pine.GSO.4.61.0412181645420.2298@slinky.cs.nyu.edu> <20041218221057.GB11307@trixie.casa.cgf.cx>
In-Reply-To: <20041218221057.GB11307@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00253.txt.bz2

Christopher Faylor schrieb:
> On Sat, Dec 18, 2004 at 04:48:50PM -0500, Igor Pechtchanski wrote:
>>There are two possible interpretations here.  One is that Reini is
>>proposing to have Cygwin tools always list alternate streams, in which
>>case you're correct, and it's unrelated to the thread.  Another is that
>>colons in filenames on certain Cygwin mounts should not represent
>>alternate streams, but should be different files altogether, and thus
>>should be listed normally.
>>
>>That said, I think Reini's wording implies your interpretation, and thus
>>his suggestion should be in a different thread.
> 
> There really isn't much that we can do with colons, AFAICT.  We
> certainly can't disallow them in the common case and I don't think there
> is any FindFirstFile/FindNextFile type API which allows us to easily
> expose them.
> 
> Although I can see that it would be nice to have a unifying philosophy here
> I think the strange behavior of a foo:bar on an NTFS file system is not
> something that we should worry about right now.

Agreed.
Some different patch for fhandler_disk_file::readdir() on managed mounts
later, when the need arises.
readdir() performance will be seriously affected, having to look in all 
regular files for such attached ADS streams.
-- 
Reini Urban
