# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

# @ECLASS: darcs.eclass
# @MAINTAINER:
# Kirixetamine <revelation@krxt.dev>
# @SUPPORTED_EAPIS: 8
# @BLURB: This eclass provides functions for the darcs vcs.
# @DESCRIPTION:
# This eclass provides functions for fetching software through darcs.
# It's as simple as setting EDARCS_REPO_URI to the correct repo URI.

case ${EAPI:-0} in
	[78]) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} is not supported" ;;
esac

EXPORT_FUNCTIONS src_unpack

PROPERTIES+=" live"

BDEPEND="dev-vcs/darcs"

# @ECLASS_VARIABLE: EDARCS_REPO_URI
# @DESCRIPTION:
# Darcs repository URI.

# @ECLASS_VARIABLE: EDARCS_PROJECT
# @DESCRIPTION:
# The project name.
[[ -z "${EDARCS_PROJECT}" ]] && EDARCS_PROJECT="${PN}"

# @ECLASS_VARIABLE: EDARCS_LAZY
# @DESCRIPTION:
# Whether to lazy clone or not, with --lazy
# Must be a boolean.

# @FUNCTION: darcs-fetch
# @USAGE: darcs_fetch
# @DESCRIPTION
# Clones a darcs project.

darcs_fetch() {
	debug-print-function ${FUNCNAME} "${@}"

	EDARCS_REPO_URI=${1-${EDARCS_REPO_URI}}
	[[ -z "${EDARCS_REPO_URI}" ]] && die "EDARCS_REPO_URI is empty"

	local repo="${2-$(basename "${EDARCS_REPO_URI}")}"

	# Create project dir
	mkdir -p "${EDARCS_PROJECT}" || \
		die "Failed to create directory ${EDARCS_PROJECT}"
	chmod -f g+rw "${EDARCS_PROJECT}" || \
		die "Failed to \"chmod -f g+rw\" ${EDARCS_PROJECT}"
	pushd "${EDARCS_PROJECT}" > /dev/null || \
		die "Failed to cd into ${EDARCS_PROJECT}"

	# Clone the repository
	if [[ ! -d "${repo}" ]]; then
		# Check whether we're cloning lazily or not
		einfo "Cloning project ${EDARCS_REPO_URI} to ${repo}"
		if [[ ${EDARCS_LAZY} == true ]]; then
			darcs clone \
				--lazy	\
				"${EDARCS_REPO_URI}" || \
				rm -rf "${repo}"
				die "darcs lazy clone failed"
		else
			darcs clone \
				"${EDARCS_REPO_URI}" || \
				rm -rf "${repo}"
				die "darcs clone failed"
		fi
	fi
	popd > /dev/null || die
}

darcs_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	darcs_fetch
}
