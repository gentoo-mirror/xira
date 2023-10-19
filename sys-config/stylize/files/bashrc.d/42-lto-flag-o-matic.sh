LTOOverrideFlagOMatic()
{
	if [[ "${LTO_ENABLE_FLAGOMATIC}" != "yes" ]]; then
		strip-flags()
		{
			ewarn "stylize: strip-flags OVERRIDDEN"
		}

        strip-unsupported-flags()
        {
            ewarn "stylize: strip-unsupported-flags OVERRIDEN"
        }

		replace-flags()
		{
			ewarn "stylize: replace-flags OVERRIDDEN"
		}

		append-flags()
		{
			ewarn "stylize: append-flags OVERRIDDEN"
		}

		filter-flags()
		{
			ewarn "stylize: filter-flags OVERRIDDEN"
		}
	fi
}


BashrcdPhase all LTOOverrideFlagOMatic
