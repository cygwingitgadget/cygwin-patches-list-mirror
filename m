Return-Path: <cygwin-patches-return-3923-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19221 invoked by alias); 4 Jun 2003 01:39:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19154 invoked from network); 4 Jun 2003 01:39:48 -0000
Date: Wed, 04 Jun 2003 01:39:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: stat weird feature
Message-ID: <20030604013954.GB5880@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030603212215.007fe100@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030603212215.007fe100@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00150.txt.bz2

On Tue, Jun 03, 2003 at 09:22:15PM -0400, Pierre A. Humblet wrote:
>Here is the patch discussed today on the developers' list.
>I have also moved a comment that had drifted out of its 
>natural spot.
>
>Pierre
>
>2003-06-04  Pierre Humblet  <pierre.humblet@ieee.org>
>
>	* fhandler_disk_file.cc (fhandler_disk_file::fstat): Mark the pc
>	as non-executable if the file cannot be opened for read. Retry query 
>	open only if errno is EACCES. Never change the mode, even if it is 000 
>	when query open() fails. 

Looks good.  Please check in.

cgf
