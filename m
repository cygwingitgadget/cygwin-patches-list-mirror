From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Don't modify const string in conv_path_list()
Date: Sat, 17 Nov 2001 12:19:00 -0000
Message-ID: <20011117201925.GB29148@redhat.com>
References: <20011117195929.7886D1BF249@duffek.com>
X-SW-Source: 2001-q4/msg00233.html
Message-ID: <20011117121900.7Q94KREB4o3YbVcZHG0n58HrPyfCu0tYOZSPIB9W4X8@z>

On Sat, Nov 17, 2001 at 02:59:29PM -0500, Nick Duffek wrote:
>Hi,
>
>On 15-Oct-2001, Robert Bogomip <bob.bogo@milohedge.com> wrote:
>
>>  bash-2.05$ (exec -c sh -c 'export PATH; ls')
>>        0 [main] sh 8724 open_stackdumpfile: Dumping stack trace to sh.exe.stackdump
>
>Here's a patch to fix that.
>
>Starting ash as above causes PATH to be a read-only compile-time string.
>When forking a subprocess, that string:
>  1. gets passed to execve() as part of the environment;
>  2. subsequently gets passed as a const char * parameter to
>     conv_path_list() in winsup/cygwin/path.cc;
>  3. becomes the target of an assignment in conv_path_list(), resulting in
>     the segmentation violation.
>
>The appended patch fixes the bug by copying PATH components instead of
>modifying PATH itself.
>
>winsup/cygwin/ChangeLog:
>
>	* path.cc (conv_path_list): Copy source paths before modifying
>	them.

Applied.

Thanks!

cgf
