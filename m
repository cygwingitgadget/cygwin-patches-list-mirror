Return-Path: <cygwin-patches-return-3895-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16293 invoked by alias); 25 May 2003 16:48:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16160 invoked from network); 25 May 2003 16:48:28 -0000
Date: Sun, 25 May 2003 16:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: df and ls for root directories on Win9X
Message-ID: <20030525164823.GA8773@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030523183423.008059c0@mail.attbi.com> <20030525091901.GA875@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525091901.GA875@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00122.txt.bz2

On Sun, May 25, 2003 at 11:19:01AM +0200, Corinna Vinschen wrote:
>On Fri, May 23, 2003 at 06:34:23PM -0400, Pierre A. Humblet wrote:
>> 2003-05-23  Pierre Humblet  <pierre.humblet@ieee.org>
>> 
>> 	* autoload.cc (GetDiskFreeSpaceEx): Add.
>> 	* syscalls.cc (statfs): Call full_path.root_dir() instead of
>> 	rootdir(full_path). Use GetDiskFreeSpaceEx when available and
>> 	report space available in addition to free space.
>> 	* fhandler_disk_file.cc (fhandler_disk_file::fstat_by_name):
>> 	Do not call FindFirstFile for disk root directories.
>
>Applied.

Um.  I am still reviewing the fstat_by_name stuff.  I will be making
changes to this.
