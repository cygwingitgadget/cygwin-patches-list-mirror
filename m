From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: Patch for the mount code.
Date: Mon, 18 Sep 2000 09:53:00 -0000
Message-id: <20000918125247.A3834@cygnus.com>
References: <s1sitrugjsl.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00097.html

Applied.

Could you notify people on the cygwin mailing list thread that you've
fixed this problem?

Many thanks,
cgf

On Mon, Sep 18, 2000 at 05:56:42PM +0900, Kazuhiro Fujieda wrote:
>The following patch solves the following issues in the mount mechanism.
>- All mount entries will be deleted if the cygdrive prefix is set to '/'.
>- Mount() accepts an inappropriate mount point such as 'C:'.
>- Mount() can't report the error `ENOPERM' if it fails to modify
>  the system registry.
>- Mount_info::add_item will incorrectly increment nmounts if it
>  fails to modify the registry.
>
>ChangeLog:
>Mon Sep 18 17:15:37 2000  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* path.cc (mount_info::read_mounts): Don't delete mount entries of
> 	which mount points have the cygdrive prefix.
>	* (mount_info::add_reg_mount): Properly catch errors on registry
> 	operations.
>	* (mount_info::write_cygdrive_info_to_registry): Ditto.
>	* (mount_info::del_reg_mount): Cosmetic changes to be consistent
>	with other methods.
>	* (mount_info::add_item): Check arguments more precisely.
>	Increment nmounts only when registry operations succeed.
