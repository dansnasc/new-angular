import Aura from '@primeuix/themes/aura';
import { bemagroTokens } from './bemagro-tokens';

// Usar Aura como base e customizar apenas o necessário
export const bemagroTheme = {
  ...Aura,
  semantic: {
    ...Aura.semantic,
    // Customizar apenas as cores primárias
    primary: {
      ...(Aura?.semantic?.primary ?? {}),
      500: bemagroTokens.colors.login.primary,    // #0F8536
      600: bemagroTokens.colors.login.primaryHover, // #0d6b2c
      700: bemagroTokens.colors.login.primaryHover, // #0d6b2c
    },
    colorScheme: {
      light: {
        ...(Aura?.semantic?.colorScheme?.light ?? {}),
        primary: {
          ...(Aura?.semantic?.colorScheme?.light?.primary ?? {}),
          color: bemagroTokens.colors.login.primary,
          hoverColor: bemagroTokens.colors.login.primaryHover,
          activeColor: bemagroTokens.colors.login.primaryHover
        }
      }
    }
  }
};
