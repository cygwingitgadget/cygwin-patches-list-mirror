Return-Path: <cygwin-patches-return-4511-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12543 invoked by alias); 7 Jan 2004 18:12:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12534 invoked from network); 7 Jan 2004 18:12:00 -0000
Date: Wed, 07 Jan 2004 18:12:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: lstat symbolic link size
Message-ID: <20040107181159.GC14105@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040106013026.21604.qmail@linuxmail.org> <20040106013824.GA6047@redhat.com> <20040106014410.GA6850@redhat.com> <Pine.GSO.4.58.0401071123210.23399@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0401071123210.23399@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00001.txt.bz2

On Wed, Jan 07, 2004 at 11:33:18AM -0600, Brian Ford wrote:
>On Mon, 5 Jan 2004, Christopher Faylor wrote:
>
>> On Mon, Jan 05, 2004 at 08:38:24PM -0500, Christopher Faylor wrote:
>> >On Tue, Jan 06, 2004 at 09:30:26AM +0800, peter garrone wrote:
>> >>lstat returns an incorrect symbolic link size, with size 11 bytes too large.
>> >>
>> >lstat reports the actual size of the symlink file.  Unless you can point
>> >to a standard which indicates this is incorrect, we'll be sticking with
>> >this long standing behavior.
>> >
>> Actually, nevermind.  SUSv3 says this:
>>
>> For symbolic links, the st_mode member shall contain meaningful
>> information when used with the file type macros, and the st_size member
>> shall contain the length of the pathname contained in the symbolic link.
>>
>> So, this is a PTC situation.
>>
>Ok, here it is.
>
>2004-01-07  Brian Ford  <ford@vss.fsi.com>
>
>	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Comply with
>	SUSv3 for a symlink's st_size, ie. the length of the target
>	pathname.

Thanks but that is not the correct fix.  The target pathname is not the
windows path.

cgf

>Index: fhandler_disk_file.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
>retrieving revision 1.75
>diff -u -p -r1.75 fhandler_disk_file.cc
>--- fhandler_disk_file.cc	15 Dec 2003 04:16:42 -0000	1.75
>+++ fhandler_disk_file.cc	7 Jan 2004 17:23:10 -0000
>@@ -291,6 +291,8 @@ fhandler_base::fstat_helper (struct __st
>     {
>       /* symlinks are everything for everyone! */
>       buf->st_mode = S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO;
>+      /* SUSv3: their size is the length of the target pathname */
>+      buf->st_size = strlen (pc.get_win32 ());
>       get_file_attribute (pc.has_acls (), get_win32_name (), NULL,
> 			  &buf->st_uid, &buf->st_gid);
>       goto done;
