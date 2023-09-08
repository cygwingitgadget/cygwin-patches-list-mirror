Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EB7263858D35; Fri,  8 Sep 2023 14:09:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EB7263858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1694182165;
	bh=ovnveoauYYUKnULwvE0lLqIEd82+wawhpRnqffH3VIE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fP65X32Wovz+o8wyacgJxwMW+lRnX0uMfysV50I81MEsAyz0MrBclKim4SfXR71XD
	 G6txqcSW5bdRPc4yV+ETrvKPaIKPFjXmSwJRheaM1riqSVR0+d7ArJ14/Oo4A84q3o
	 dmcagX9YCKfPB7+V8MFvhmyrVbtJ837/uoxukYqI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 46EECA80850; Fri,  8 Sep 2023 16:09:24 +0200 (CEST)
Date: Fri, 8 Sep 2023 16:09:24 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add initial support for SOURCE_DATE_EPOCH
Message-ID: <ZPsrFKgcmt2qrH34@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	cygwin-patches@cygwin.com
References: <a1890367-b100-2321-aca4-17eec98ebba7@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1890367-b100-2321-aca4-17eec98ebba7@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Jon,

you did all the latest work in terms of the build machinery.
Would you mind to review this patch, please?


Thanks,
Corinna

On Sep  5 19:01, Christian Franke wrote:
> This patch enables reproducible builds of cygwin package in conjunction with
> this cygport patch:
> https://sourceware.org/pipermail/cygwin-apps/2023-August/043108.html
> 
> cygwin.cygport was enhanced for the test as described in the above post.
> 
> If the same build path, SOURCE_DATE_EPOCH and toolchain are used, rebuilds
> with cygport produce identical distribution tarballs. Adding proper
> -fmacro-prefix-map gcc options (or remove all usages of __FILE__) could
> possibly make this independent from the build path.
> 
> Note that 'u' (replace with newer objects only) flag needed to be removed
> from ar commands because it is incompatible with 'D' (deterministic
> archive). I don't expect any negative effect because existing .a files are
> always removed before ar is run.
> 
> Not yet tested with different machines or different users accounts.
> 
> Patch would be much simpler (mkvers.sh only) if binutils would support
> SOURCE_DATE_EPOCH directly.
> 
> -- 
> Regards,
> Christian
> 

> From b877330d53b95a88f1aef0fa3d14e97910d9dd2a Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Tue, 5 Sep 2023 18:32:49 +0200
> Subject: [PATCH] Add initial support for SOURCE_DATE_EPOCH
> 
> If specified, set version timestamp to this value.
> Enable deterministic archives for ar and ranlib.
> Set cygwin1.dll PE and export table header timestamps
> to zero.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/Makefile.am       | 6 ++++++
>  winsup/cygwin/scripts/mkimport  | 6 +++++-
>  winsup/cygwin/scripts/mkvers.sh | 4 ++--
>  winsup/cygwin/scripts/speclib   | 6 +++++-
>  4 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
> index 9912b5399..64b252a22 100644
> --- a/winsup/cygwin/Makefile.am
> +++ b/winsup/cygwin/Makefile.am
> @@ -572,6 +572,10 @@ toollib_DATA = \
>  libgmon_a_SOURCES = $(GMON_FILES)
>  libgmon_a_LIBADD =
>  
> +# Enable deterministic archives for reproducible builds.
> +ARFLAGS = cr$${SOURCE_DATE_EPOCH:+D}
> +override RANLIB := $(RANLIB)$${SOURCE_DATE_EPOCH:+ -D}
> +
>  # cygserver library
>  cygserver_blddir = ${target_builddir}/winsup/cygserver
>  LIBSERVER = $(cygserver_blddir)/libcygserver.a
> @@ -589,12 +593,14 @@ $(LDSCRIPT): $(LDSCRIPT).in
>  	$(AM_V_GEN)$(CC) -E - -P < $^ -o $@
>  
>  # cygwin dll
> +# Set PE and export table header timestamps to zero for reproducible builds.
>  $(NEW_DLL_NAME): $(LDSCRIPT) libdll.a $(VERSION_OFILES) $(LIBSERVER)\
>  		  $(newlib_build)/libm.a $(newlib_build)/libc.a
>  	$(AM_V_CXXLD)$(CXX) $(CXXFLAGS) \
>  	-mno-use-libstdc-wrappers \
>  	-Wl,--gc-sections -nostdlib -Wl,-T$(LDSCRIPT) \
>  	-Wl,--dynamicbase -static \
> +	$${SOURCE_DATE_EPOCH:+-Wl,--no-insert-timestamp} \
>  	-Wl,--heap=0 -Wl,--out-implib,cygdll.a -shared -o $@ \
>  	-e @DLL_ENTRY@ $(DEF_FILE) \
>  	-Wl,-whole-archive libdll.a -Wl,-no-whole-archive \
> diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mkimport
> index 7684a8f0e..9517c4e9e 100755
> --- a/winsup/cygwin/scripts/mkimport
> +++ b/winsup/cygwin/scripts/mkimport
> @@ -92,8 +92,12 @@ for my $f (keys %text) {
>      }
>  }
>  
> +# Enable deterministic archives for reproducible builds.
> +my $opts = 'crs';
> +$opts .= 'D' if ($ENV{'SOURCE_DATE_EPOCH'} != '');
> +
>  unlink $libdll;
> -system $ar, 'crus', $libdll, glob('*.o'), @ARGV;
> +system $ar, $opts, $libdll, glob('*.o'), @ARGV;
>  unlink glob('*.o');
>  exit 1 if $?;
>  
> diff --git a/winsup/cygwin/scripts/mkvers.sh b/winsup/cygwin/scripts/mkvers.sh
> index 96af936ec..38f439cd0 100755
> --- a/winsup/cygwin/scripts/mkvers.sh
> +++ b/winsup/cygwin/scripts/mkvers.sh
> @@ -56,9 +56,9 @@ parse_preproc_flags $CC
>  
>  
>  #
> -# Load the current date so we can work on individual fields
> +# Load the current date (or SOURCE_DATE_EPOCH) so we can work on individual fields
>  #
> -set -$- $(date -u +"%m %d %Y %H:%M")
> +set -$- $(date ${SOURCE_DATE_EPOCH:+-d @}${SOURCE_DATE_EPOCH} -u +"%m %d %Y %H:%M")
>  m=$1 d=$2 y=$3 hhmm=$4
>  #
>  # Set date into YYYY-MM-DD HH:MM:SS format
> diff --git a/winsup/cygwin/scripts/speclib b/winsup/cygwin/scripts/speclib
> index e6d4d8e94..41a3a8e13 100755
> --- a/winsup/cygwin/scripts/speclib
> +++ b/winsup/cygwin/scripts/speclib
> @@ -74,7 +74,11 @@ EOF
>  close $as_fd or exit 1;
>  system $objcopy, '-j', '.idata$7', $iname_o;
>  
> -$res = system $ar, 'crus', $lib, sort keys %extract;
> +# Enable deterministic archives for reproducible builds.
> +my $opts = 'crs';
> +$opts .= 'D' if ($ENV{'SOURCE_DATE_EPOCH'} != '');
> +
> +$res = system $ar, $opts, $lib, sort keys %extract;
>  unlink keys %extract;
>  die "$0: ar creation of $lib exited with non-zero status\n" if $res;
>  exit 0;
> -- 
> 2.39.0
> 

